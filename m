From: Geert Bosch <bosch@adacore.com>
Subject: RFC: New diff-delta.c implementation
Date: Fri, 21 Apr 2006 17:16:10 -0400
Message-ID: <602974A9-09A3-46E9-92D6-D30728923C11@adacore.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: multipart/mixed; boundary=Apple-Mail-3--156753544
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 21 23:16:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FX2zH-0002JQ-Ag
	for gcvg-git@gmane.org; Fri, 21 Apr 2006 23:16:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbWDUVQT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Apr 2006 17:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbWDUVQT
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Apr 2006 17:16:19 -0400
Received: from nile.gnat.com ([205.232.38.5]:1781 "EHLO nile.gnat.com")
	by vger.kernel.org with ESMTP id S964783AbWDUVQS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Apr 2006 17:16:18 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtered-nile.gnat.com (Postfix) with ESMTP id 1E11C48CEC8;
	Fri, 21 Apr 2006 17:16:13 -0400 (EDT)
Received: from nile.gnat.com ([127.0.0.1])
 by localhost (nile.gnat.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 05584-01-4; Fri, 21 Apr 2006 17:16:12 -0400 (EDT)
Received: from [205.232.38.124] (potomac.gnat.com [205.232.38.124])
	by nile.gnat.com (Postfix) with ESMTP id C84BB48CEC4;
	Fri, 21 Apr 2006 17:16:12 -0400 (EDT)
To: Git Mailing List <git@vger.kernel.org>
X-Mailer: Apple Mail (2.749.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19032>


--Apple-Mail-3--156753544
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed

I wrote a new binary differencing algorithm that is both faster
and generates smaller deltas than the current implementation.
The format is compatible with that used by patch-delta, so
it should be easy to integrate.

Originally, I wrote this for the GDIFF format, see http://www.w3.org/ 
TR/NOTE-gdiff-19970901.
The adaptation for GIT format was relatively simple, but is not  
thoroughly tested.
The code is not derived from libxdiff, but uses the rabin_slide  
function written
by David Mazieres (dm@uun.org). Also the tables are generated using  
his code.
Finally, this was developed on Darwin, and not a Linux system, so  
some changes may be needed.

Initial testing seems quite positive, take for example git-1.2.5.tar  
vs git-1.2.6.tar
on my PowerBook (both with -O2 -DNDEBUG):

current: 2.281s, patch size 36563
new    : 0.109s, patch size 16199

Please feel free to play around with this code, and give feedback.
Keep in mind this wasn't originally written for GIT, and C is not
my native language, so don't mind my formatting etc.

   -Geert


--Apple-Mail-3--156753544
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="diff-delta.c"
Content-Disposition: attachment;
	filename=diff-delta.c

#include <unistd.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include <sys/types.h>

/* MIN_HTAB_SIZE is fixed amount to be added to the size of the hash table
   used for indexing and must be a power of two. This allows for small files
   to have a sparse hash table, since in that case it's cheap.
   Hash table sizes are rounded up to a power of two to avoid integer division.
*/
#define MIN_HTAB_SIZE 8192
#define MAX_HTAB_SIZE (1024*1024*1024)

/* Diffing files of gigabyte range is impractical with the current
   algorithm, so we're assuming 32-bit sizes everywhere.
   Size leaves some room for expansion when diffing random files.  */
#define MAX_SIZE (0x7eff0000)
/* Initial size of copies table, dynamically extended as needed. */
#define MAX_COPIES 4096

/* Matching is done using a sliding window for which a Rabin
   polynomial is computed. The advantage of such polynomials is
   that they can efficiently be updated at every position.
   The tables needed for this are precomputed, as it is desirable
   to use the same polynomial all the time for repeatable results.
*/

#define RABIN_WINDOW_SIZE 22
#define RABIN_SHIFT 55

static unsigned long long T[256] =
{ 0x0000000000000000ULL, 0xb15e234bd3792f63ULL, 0x62bc4697a6f25ec6ULL,
  0xd3e265dc758b71a5ULL, 0x7426ae649e9d92efULL, 0xc5788d2f4de4bd8cULL,
  0x169ae8f3386fcc29ULL, 0xa7c4cbb8eb16e34aULL, 0x59137f82ee420abdULL,
  0xe84d5cc93d3b25deULL, 0x3baf391548b0547bULL, 0x8af11a5e9bc97b18ULL,
  0x2d35d1e670df9852ULL, 0x9c6bf2ada3a6b731ULL, 0x4f899771d62dc694ULL,
  0xfed7b43a0554e9f7ULL, 0x0378dc4e0ffd3a19ULL, 0xb226ff05dc84157aULL,
  0x61c49ad9a90f64dfULL, 0xd09ab9927a764bbcULL, 0x775e722a9160a8f6ULL,
  0xc600516142198795ULL, 0x15e234bd3792f630ULL, 0xa4bc17f6e4ebd953ULL,
  0x5a6ba3cce1bf30a4ULL, 0xeb35808732c61fc7ULL, 0x38d7e55b474d6e62ULL,
  0x8989c61094344101ULL, 0x2e4d0da87f22a24bULL, 0x9f132ee3ac5b8d28ULL,
  0x4cf14b3fd9d0fc8dULL, 0xfdaf68740aa9d3eeULL, 0x06f1b89c1ffa7432ULL,
  0xb7af9bd7cc835b51ULL, 0x644dfe0bb9082af4ULL, 0xd513dd406a710597ULL,
  0x72d716f88167e6ddULL, 0xc38935b3521ec9beULL, 0x106b506f2795b81bULL,
  0xa1357324f4ec9778ULL, 0x5fe2c71ef1b87e8fULL, 0xeebce45522c151ecULL,
  0x3d5e8189574a2049ULL, 0x8c00a2c284330f2aULL, 0x2bc4697a6f25ec60ULL,
  0x9a9a4a31bc5cc303ULL, 0x49782fedc9d7b2a6ULL, 0xf8260ca61aae9dc5ULL,
  0x058964d210074e2bULL, 0xb4d74799c37e6148ULL, 0x67352245b6f510edULL,
  0xd66b010e658c3f8eULL, 0x71afcab68e9adcc4ULL, 0xc0f1e9fd5de3f3a7ULL,
  0x13138c2128688202ULL, 0xa24daf6afb11ad61ULL, 0x5c9a1b50fe454496ULL,
  0xedc4381b2d3c6bf5ULL, 0x3e265dc758b71a50ULL, 0x8f787e8c8bce3533ULL,
  0x28bcb53460d8d679ULL, 0x99e2967fb3a1f91aULL, 0x4a00f3a3c62a88bfULL,
  0xfb5ed0e81553a7dcULL, 0x0de371383ff4e864ULL, 0xbcbd5273ec8dc707ULL,
  0x6f5f37af9906b6a2ULL, 0xde0114e44a7f99c1ULL, 0x79c5df5ca1697a8bULL,
  0xc89bfc17721055e8ULL, 0x1b7999cb079b244dULL, 0xaa27ba80d4e20b2eULL,
  0x54f00ebad1b6e2d9ULL, 0xe5ae2df102cfcdbaULL, 0x364c482d7744bc1fULL,
  0x87126b66a43d937cULL, 0x20d6a0de4f2b7036ULL, 0x918883959c525f55ULL,
  0x426ae649e9d92ef0ULL, 0xf334c5023aa00193ULL, 0x0e9bad763009d27dULL,
  0xbfc58e3de370fd1eULL, 0x6c27ebe196fb8cbbULL, 0xdd79c8aa4582a3d8ULL,
  0x7abd0312ae944092ULL, 0xcbe320597ded6ff1ULL, 0x1801458508661e54ULL,
  0xa95f66cedb1f3137ULL, 0x5788d2f4de4bd8c0ULL, 0xe6d6f1bf0d32f7a3ULL,
  0x3534946378b98606ULL, 0x846ab728abc0a965ULL, 0x23ae7c9040d64a2fULL,
  0x92f05fdb93af654cULL, 0x41123a07e62414e9ULL, 0xf04c194c355d3b8aULL,
  0x0b12c9a4200e9c56ULL, 0xba4ceaeff377b335ULL, 0x69ae8f3386fcc290ULL,
  0xd8f0ac785585edf3ULL, 0x7f3467c0be930eb9ULL, 0xce6a448b6dea21daULL,
  0x1d8821571861507fULL, 0xacd6021ccb187f1cULL, 0x5201b626ce4c96ebULL,
  0xe35f956d1d35b988ULL, 0x30bdf0b168bec82dULL, 0x81e3d3fabbc7e74eULL,
  0x2627184250d10404ULL, 0x97793b0983a82b67ULL, 0x449b5ed5f6235ac2ULL,
  0xf5c57d9e255a75a1ULL, 0x086a15ea2ff3a64fULL, 0xb93436a1fc8a892cULL,
  0x6ad6537d8901f889ULL, 0xdb8870365a78d7eaULL, 0x7c4cbb8eb16e34a0ULL,
  0xcd1298c562171bc3ULL, 0x1ef0fd19179c6a66ULL, 0xafaede52c4e54505ULL,
  0x51796a68c1b1acf2ULL, 0xe027492312c88391ULL, 0x33c52cff6743f234ULL,
  0x829b0fb4b43add57ULL, 0x255fc40c5f2c3e1dULL, 0x9401e7478c55117eULL,
  0x47e3829bf9de60dbULL, 0xf6bda1d02aa74fb8ULL, 0x1bc6e2707fe9d0c8ULL,
  0xaa98c13bac90ffabULL, 0x797aa4e7d91b8e0eULL, 0xc82487ac0a62a16dULL,
  0x6fe04c14e1744227ULL, 0xdebe6f5f320d6d44ULL, 0x0d5c0a8347861ce1ULL,
  0xbc0229c894ff3382ULL, 0x42d59df291abda75ULL, 0xf38bbeb942d2f516ULL,
  0x2069db65375984b3ULL, 0x9137f82ee420abd0ULL, 0x36f333960f36489aULL,
  0x87ad10dddc4f67f9ULL, 0x544f7501a9c4165cULL, 0xe511564a7abd393fULL,
  0x18be3e3e7014ead1ULL, 0xa9e01d75a36dc5b2ULL, 0x7a0278a9d6e6b417ULL,
  0xcb5c5be2059f9b74ULL, 0x6c98905aee89783eULL, 0xddc6b3113df0575dULL,
  0x0e24d6cd487b26f8ULL, 0xbf7af5869b02099bULL, 0x41ad41bc9e56e06cULL,
  0xf0f362f74d2fcf0fULL, 0x2311072b38a4beaaULL, 0x924f2460ebdd91c9ULL,
  0x358befd800cb7283ULL, 0x84d5cc93d3b25de0ULL, 0x5737a94fa6392c45ULL,
  0xe6698a0475400326ULL, 0x1d375aec6013a4faULL, 0xac6979a7b36a8b99ULL,
  0x7f8b1c7bc6e1fa3cULL, 0xced53f301598d55fULL, 0x6911f488fe8e3615ULL,
  0xd84fd7c32df71976ULL, 0x0badb21f587c68d3ULL, 0xbaf391548b0547b0ULL,
  0x4424256e8e51ae47ULL, 0xf57a06255d288124ULL, 0x269863f928a3f081ULL,
  0x97c640b2fbdadfe2ULL, 0x30028b0a10cc3ca8ULL, 0x815ca841c3b513cbULL,
  0x52becd9db63e626eULL, 0xe3e0eed665474d0dULL, 0x1e4f86a26fee9ee3ULL,
  0xaf11a5e9bc97b180ULL, 0x7cf3c035c91cc025ULL, 0xcdade37e1a65ef46ULL,
  0x6a6928c6f1730c0cULL, 0xdb370b8d220a236fULL, 0x08d56e51578152caULL,
  0xb98b4d1a84f87da9ULL, 0x475cf92081ac945eULL, 0xf602da6b52d5bb3dULL,
  0x25e0bfb7275eca98ULL, 0x94be9cfcf427e5fbULL, 0x337a57441f3106b1ULL,
  0x8224740fcc4829d2ULL, 0x51c611d3b9c35877ULL, 0xe09832986aba7714ULL,
  0x16259348401d38acULL, 0xa77bb003936417cfULL, 0x7499d5dfe6ef666aULL,
  0xc5c7f69435964909ULL, 0x62033d2cde80aa43ULL, 0xd35d1e670df98520ULL,
  0x00bf7bbb7872f485ULL, 0xb1e158f0ab0bdbe6ULL, 0x4f36eccaae5f3211ULL,
  0xfe68cf817d261d72ULL, 0x2d8aaa5d08ad6cd7ULL, 0x9cd48916dbd443b4ULL,
  0x3b1042ae30c2a0feULL, 0x8a4e61e5e3bb8f9dULL, 0x59ac04399630fe38ULL,
  0xe8f227724549d15bULL, 0x155d4f064fe002b5ULL, 0xa4036c4d9c992dd6ULL,
  0x77e10991e9125c73ULL, 0xc6bf2ada3a6b7310ULL, 0x617be162d17d905aULL,
  0xd025c2290204bf39ULL, 0x03c7a7f5778fce9cULL, 0xb29984bea4f6e1ffULL,
  0x4c4e3084a1a20808ULL, 0xfd1013cf72db276bULL, 0x2ef27613075056ceULL,
  0x9fac5558d42979adULL, 0x38689ee03f3f9ae7ULL, 0x8936bdabec46b584ULL,
  0x5ad4d87799cdc421ULL, 0xeb8afb3c4ab4eb42ULL, 0x10d42bd45fe74c9eULL,
  0xa18a089f8c9e63fdULL, 0x72686d43f9151258ULL, 0xc3364e082a6c3d3bULL,
  0x64f285b0c17ade71ULL, 0xd5aca6fb1203f112ULL, 0x064ec327678880b7ULL,
  0xb710e06cb4f1afd4ULL, 0x49c75456b1a54623ULL, 0xf899771d62dc6940ULL,
  0x2b7b12c1175718e5ULL, 0x9a25318ac42e3786ULL, 0x3de1fa322f38d4ccULL,
  0x8cbfd979fc41fbafULL, 0x5f5dbca589ca8a0aULL, 0xee039fee5ab3a569ULL,
  0x13acf79a501a7687ULL, 0xa2f2d4d1836359e4ULL, 0x7110b10df6e82841ULL,
  0xc04e924625910722ULL, 0x678a59fece87e468ULL, 0xd6d47ab51dfecb0bULL,
  0x05361f696875baaeULL, 0xb4683c22bb0c95cdULL, 0x4abf8818be587c3aULL,
  0xfbe1ab536d215359ULL, 0x2803ce8f18aa22fcULL, 0x995dedc4cbd30d9fULL,
  0x3e99267c20c5eed5ULL, 0x8fc70537f3bcc1b6ULL, 0x5c2560eb8637b013ULL,
  0xed7b43a0554e9f70ULL
};

static unsigned long long U[256] =
{ 0x0000000000000000ULL, 0x079343d61ab9f60eULL, 0x0f2687ac3573ec1cULL,
  0x08b5c47a2fca1a12ULL, 0x1e4d0f586ae7d838ULL, 0x19de4c8e705e2e36ULL,
  0x116b88f45f943424ULL, 0x16f8cb22452dc22aULL, 0x3c9a1eb0d5cfb070ULL,
  0x3b095d66cf76467eULL, 0x33bc991ce0bc5c6cULL, 0x342fdacafa05aa62ULL,
  0x22d711e8bf286848ULL, 0x2544523ea5919e46ULL, 0x2df196448a5b8454ULL,
  0x2a62d59290e2725aULL, 0x79343d61ab9f60e0ULL, 0x7ea77eb7b12696eeULL,
  0x7612bacd9eec8cfcULL, 0x7181f91b84557af2ULL, 0x67793239c178b8d8ULL,
  0x60ea71efdbc14ed6ULL, 0x685fb595f40b54c4ULL, 0x6fccf643eeb2a2caULL,
  0x45ae23d17e50d090ULL, 0x423d600764e9269eULL, 0x4a88a47d4b233c8cULL,
  0x4d1be7ab519aca82ULL, 0x5be32c8914b708a8ULL, 0x5c706f5f0e0efea6ULL,
  0x54c5ab2521c4e4b4ULL, 0x5356e8f33b7d12baULL, 0x433659888447eea3ULL,
  0x44a51a5e9efe18adULL, 0x4c10de24b13402bfULL, 0x4b839df2ab8df4b1ULL,
  0x5d7b56d0eea0369bULL, 0x5ae81506f419c095ULL, 0x525dd17cdbd3da87ULL,
  0x55ce92aac16a2c89ULL, 0x7fac473851885ed3ULL, 0x783f04ee4b31a8ddULL,
  0x708ac09464fbb2cfULL, 0x771983427e4244c1ULL, 0x61e148603b6f86ebULL,
  0x66720bb621d670e5ULL, 0x6ec7cfcc0e1c6af7ULL, 0x69548c1a14a59cf9ULL,
  0x3a0264e92fd88e43ULL, 0x3d91273f3561784dULL, 0x3524e3451aab625fULL,
  0x32b7a09300129451ULL, 0x244f6bb1453f567bULL, 0x23dc28675f86a075ULL,
  0x2b69ec1d704cba67ULL, 0x2cfaafcb6af54c69ULL, 0x06987a59fa173e33ULL,
  0x010b398fe0aec83dULL, 0x09befdf5cf64d22fULL, 0x0e2dbe23d5dd2421ULL,
  0x18d5750190f0e60bULL, 0x1f4636d78a491005ULL, 0x17f3f2ada5830a17ULL,
  0x1060b17bbf3afc19ULL, 0x3732905adbf6f225ULL, 0x30a1d38cc14f042bULL,
  0x381417f6ee851e39ULL, 0x3f875420f43ce837ULL, 0x297f9f02b1112a1dULL,
  0x2eecdcd4aba8dc13ULL, 0x265918ae8462c601ULL, 0x21ca5b789edb300fULL,
  0x0ba88eea0e394255ULL, 0x0c3bcd3c1480b45bULL, 0x048e09463b4aae49ULL,
  0x031d4a9021f35847ULL, 0x15e581b264de9a6dULL, 0x1276c2647e676c63ULL,
  0x1ac3061e51ad7671ULL, 0x1d5045c84b14807fULL, 0x4e06ad3b706992c5ULL,
  0x4995eeed6ad064cbULL, 0x41202a97451a7ed9ULL, 0x46b369415fa388d7ULL,
  0x504ba2631a8e4afdULL, 0x57d8e1b50037bcf3ULL, 0x5f6d25cf2ffda6e1ULL,
  0x58fe6619354450efULL, 0x729cb38ba5a622b5ULL, 0x750ff05dbf1fd4bbULL,
  0x7dba342790d5cea9ULL, 0x7a2977f18a6c38a7ULL, 0x6cd1bcd3cf41fa8dULL,
  0x6b42ff05d5f80c83ULL, 0x63f73b7ffa321691ULL, 0x646478a9e08be09fULL,
  0x7404c9d25fb11c86ULL, 0x73978a044508ea88ULL, 0x7b224e7e6ac2f09aULL,
  0x7cb10da8707b0694ULL, 0x6a49c68a3556c4beULL, 0x6dda855c2fef32b0ULL,
  0x656f4126002528a2ULL, 0x62fc02f01a9cdeacULL, 0x489ed7628a7eacf6ULL,
  0x4f0d94b490c75af8ULL, 0x47b850cebf0d40eaULL, 0x402b1318a5b4b6e4ULL,
  0x56d3d83ae09974ceULL, 0x51409becfa2082c0ULL, 0x59f55f96d5ea98d2ULL,
  0x5e661c40cf536edcULL, 0x0d30f4b3f42e7c66ULL, 0x0aa3b765ee978a68ULL,
  0x0216731fc15d907aULL, 0x058530c9dbe46674ULL, 0x137dfbeb9ec9a45eULL,
  0x14eeb83d84705250ULL, 0x1c5b7c47abba4842ULL, 0x1bc83f91b103be4cULL,
  0x31aaea0321e1cc16ULL, 0x3639a9d53b583a18ULL, 0x3e8c6daf1492200aULL,
  0x391f2e790e2bd604ULL, 0x2fe7e55b4b06142eULL, 0x2874a68d51bfe220ULL,
  0x20c162f77e75f832ULL, 0x2752212164cc0e3cULL, 0x6e6520b5b7ede44aULL,
  0x69f66363ad541244ULL, 0x6143a719829e0856ULL, 0x66d0e4cf9827fe58ULL,
  0x70282feddd0a3c72ULL, 0x77bb6c3bc7b3ca7cULL, 0x7f0ea841e879d06eULL,
  0x789deb97f2c02660ULL, 0x52ff3e056222543aULL, 0x556c7dd3789ba234ULL,
  0x5dd9b9a95751b826ULL, 0x5a4afa7f4de84e28ULL, 0x4cb2315d08c58c02ULL,
  0x4b21728b127c7a0cULL, 0x4394b6f13db6601eULL, 0x4407f527270f9610ULL,
  0x17511dd41c7284aaULL, 0x10c25e0206cb72a4ULL, 0x18779a78290168b6ULL,
  0x1fe4d9ae33b89eb8ULL, 0x091c128c76955c92ULL, 0x0e8f515a6c2caa9cULL,
  0x063a952043e6b08eULL, 0x01a9d6f6595f4680ULL, 0x2bcb0364c9bd34daULL,
  0x2c5840b2d304c2d4ULL, 0x24ed84c8fcced8c6ULL, 0x237ec71ee6772ec8ULL,
  0x35860c3ca35aece2ULL, 0x32154feab9e31aecULL, 0x3aa08b90962900feULL,
  0x3d33c8468c90f6f0ULL, 0x2d53793d33aa0ae9ULL, 0x2ac03aeb2913fce7ULL,
  0x2275fe9106d9e6f5ULL, 0x25e6bd471c6010fbULL, 0x331e7665594dd2d1ULL,
  0x348d35b343f424dfULL, 0x3c38f1c96c3e3ecdULL, 0x3babb21f7687c8c3ULL,
  0x11c9678de665ba99ULL, 0x165a245bfcdc4c97ULL, 0x1eefe021d3165685ULL,
  0x197ca3f7c9afa08bULL, 0x0f8468d58c8262a1ULL, 0x08172b03963b94afULL,
  0x00a2ef79b9f18ebdULL, 0x0731acafa34878b3ULL, 0x5467445c98356a09ULL,
  0x53f4078a828c9c07ULL, 0x5b41c3f0ad468615ULL, 0x5cd28026b7ff701bULL,
  0x4a2a4b04f2d2b231ULL, 0x4db908d2e86b443fULL, 0x450ccca8c7a15e2dULL,
  0x429f8f7edd18a823ULL, 0x68fd5aec4dfada79ULL, 0x6f6e193a57432c77ULL,
  0x67dbdd4078893665ULL, 0x60489e966230c06bULL, 0x76b055b4271d0241ULL,
  0x712316623da4f44fULL, 0x7996d218126eee5dULL, 0x7e0591ce08d71853ULL,
  0x5957b0ef6c1b166fULL, 0x5ec4f33976a2e061ULL, 0x567137435968fa73ULL,
  0x51e2749543d10c7dULL, 0x471abfb706fcce57ULL, 0x4089fc611c453859ULL,
  0x483c381b338f224bULL, 0x4faf7bcd2936d445ULL, 0x65cdae5fb9d4a61fULL,
  0x625eed89a36d5011ULL, 0x6aeb29f38ca74a03ULL, 0x6d786a25961ebc0dULL,
  0x7b80a107d3337e27ULL, 0x7c13e2d1c98a8829ULL, 0x74a626abe640923bULL,
  0x7335657dfcf96435ULL, 0x20638d8ec784768fULL, 0x27f0ce58dd3d8081ULL,
  0x2f450a22f2f79a93ULL, 0x28d649f4e84e6c9dULL, 0x3e2e82d6ad63aeb7ULL,
  0x39bdc100b7da58b9ULL, 0x3108057a981042abULL, 0x369b46ac82a9b4a5ULL,
  0x1cf9933e124bc6ffULL, 0x1b6ad0e808f230f1ULL, 0x13df149227382ae3ULL,
  0x144c57443d81dcedULL, 0x02b49c6678ac1ec7ULL, 0x0527dfb06215e8c9ULL,
  0x0d921bca4ddff2dbULL, 0x0a01581c576604d5ULL, 0x1a61e967e85cf8ccULL,
  0x1df2aab1f2e50ec2ULL, 0x15476ecbdd2f14d0ULL, 0x12d42d1dc796e2deULL,
  0x042ce63f82bb20f4ULL, 0x03bfa5e99802d6faULL, 0x0b0a6193b7c8cce8ULL,
  0x0c992245ad713ae6ULL, 0x26fbf7d73d9348bcULL, 0x2168b401272abeb2ULL,
  0x29dd707b08e0a4a0ULL, 0x2e4e33ad125952aeULL, 0x38b6f88f57749084ULL,
  0x3f25bb594dcd668aULL, 0x37907f2362077c98ULL, 0x30033cf578be8a96ULL,
  0x6355d40643c3982cULL, 0x64c697d0597a6e22ULL, 0x6c7353aa76b07430ULL,
  0x6be0107c6c09823eULL, 0x7d18db5e29244014ULL, 0x7a8b9888339db61aULL,
  0x723e5cf21c57ac08ULL, 0x75ad1f2406ee5a06ULL, 0x5fcfcab6960c285cULL,
  0x585c89608cb5de52ULL, 0x50e94d1aa37fc440ULL, 0x577a0eccb9c6324eULL,
  0x4182c5eefcebf064ULL, 0x46118638e652066aULL, 0x4ea44242c9981c78ULL,
  0x49370194d321ea76ULL
};

static unsigned char rabin_window[RABIN_WINDOW_SIZE];
static unsigned rabin_pos = 0;
static void rabin_reset();
static u_int64_t rabin_slide(u_int64_t fp, unsigned char m);

#define MIN(x,y) ((y)<(x) ? (y) : (x))
#define MAX(x,y) ((y)>(x) ? (y) : (x))

/* FIXME: There must be a better way to do this... */
#if !defined(_BIG_ENDIAN) && defined(__BIG_ENDIAN) && defined(__BYTE_ORDER)
static const int big_endian = (__BYTE_ORDER == __BIG_ENDIAN);
#elif !defined(_BIG_ENDIAN) && !defined(_LITTLE_ENDIAN)
#error "Exactly one of _BIG_ENDIAN or _LITTLE_ENDIAN must be defined"
#elif defined(_BIG_ENDIAN) && defined(_LITTLE_ENDIAN)
#error "Only one of _BIG_ENDIAN or _LITTLE_ENDIAN may be defined"
#elif defined(_BIG_ENDIAN)
static const int big_endian = 1;
#else
static cont int big_endian = 0;
#endif

/* The copies array is the central data structure for 
   diff generation.  Data statements are implicit, 
   for ranges not covered by any copy command.

   The sum of tgt and length for each entry must be
   monotonically increasing, and data ranges 
   must be non-overlapping. This is accomplished by
   not extending matches backwards during initial matching.

   Copies may have zero length, to make it quick to
   delete copies during optimization. However, the last
   copy in the list must always be a non-trivial copy.

   Before committing copies, an important optimization
   is performed: during a backward pass through the copies array,
   each entry is extended backwards, and redundant copies are
   eliminated.

   If each match were extended backwards on insertion, the same
   data may be matched an arbitrary number of times, resulting in
   potentially quadratic time behavior.
*/

typedef struct copyinfo
{ unsigned	src;
  unsigned	tgt;
  unsigned	length;
} CopyInfo;
  
static CopyInfo *copies;
static int	copy_count = 0;
static unsigned max_copies = 0; /* Dynamically increased */

static unsigned *idx;
static unsigned idx_size;
static unsigned char *idx_data;
static unsigned idx_data_len;

static void
rabin_reset ()
{ bzero (rabin_window, sizeof (rabin_window));
}

static u_int64_t
rabin_slide (u_int64_t fp, unsigned char m)
{ unsigned char om;
  if (++rabin_pos == RABIN_WINDOW_SIZE) rabin_pos = 0;
  om = rabin_window[rabin_pos];
  fp ^= U[om];
  rabin_window[rabin_pos] = m;
  fp = ((fp << 8) | m) ^ T[fp >> RABIN_SHIFT];

  return fp;
}

void init_idx (unsigned char *data, size_t len, int level)
{ static unsigned index_step 
                 = RABIN_WINDOW_SIZE / sizeof (unsigned) * sizeof (unsigned);
  size_t j, k;
  unsigned char ch = 0;
  unsigned maxofs[256];
  unsigned maxlen[256];
  unsigned maxfp[256];
  unsigned runlen = 0;
  u_int64_t fp = 0;

  assert (len <= MAX_SIZE);
  assert (level >= 0 && level <= 9);
  bzero (maxofs, 256 * sizeof (unsigned));
  bzero (maxlen, 256 * sizeof (unsigned));
  bzero (maxfp, 256 * sizeof (unsigned));

  /* index_step must be multiple of word size */
  if (level >= 1)
  { index_step = MIN (index_step, 4 * sizeof (unsigned));
    /* Use smaller step size for higher optimization levels or smaller files */
    if (level >= 3 || len <= 65536)
    { index_step = MIN (index_step, 3 * sizeof (unsigned));
    }
    if (level >= 4 || len <= 32768)
    { index_step = MIN (index_step, 2 * sizeof (unsigned));
    }
    if (level >= 6 || len < 16384)
    { index_step = MIN (index_step, 1 * sizeof (unsigned));
  } }
  assert (index_step && !(index_step % sizeof (unsigned)));

  /* Add fixed amount to hash table size, as small files will benefit
     a lot without using significantly more memory or time. */
  idx_size = (level + 1) * (len / index_step) / 2 + MIN_HTAB_SIZE;
  idx_size = MIN (idx_size, MAX_HTAB_SIZE - 1); /* So rounding up works */

  /* Round up to next power of two, but limit to MAX_HTAB_SIZE. */
  { unsigned s = MIN_HTAB_SIZE;
    while (s < idx_size) s += s;
    idx_size = s;
  }

  idx_data = data;
  idx_data_len = len;
  idx = (unsigned *) calloc (idx_size, sizeof (unsigned)); 

  /* It is tempting to first index higher addresses, so hashes of lower
     addresses will get preference in the hash table. However, for
     repetitive patterns with a period that is a divisor of the fingerprint
     window, this may mean the match is not anchored at the end. 
     Furthermore, even when using a window length that is prime, the
     benefits are small and the irregularity of the first matches being
     more important is not worth it. */

  rabin_reset();
  
  ch = 0;
  runlen = 0;

  for (j = 0; j + index_step < len; j += index_step)
  { unsigned char pch = 0;
    unsigned hash;

    /* hot loop, use word loads. */
    for (k = 0; k < index_step; k+= sizeof (unsigned))
    { unsigned w = *((unsigned *) (data + (j + k)));
      unsigned n;

      for (n = 0; n < sizeof (unsigned); n++)
      { pch = ch;
        ch = big_endian ? (w>>24) & 0xff : w & 0xff;
        w = big_endian ? (w<<8) : (w>>8);
        if (ch != pch) runlen = 0;
        runlen++;
        fp = rabin_slide (fp, ch);
    } }

    /* See if there is a word-aligned window-sized run of equal characters */
    if (runlen >= RABIN_WINDOW_SIZE + (sizeof (unsigned) - 1))
    { /* Skip ahead to end of run of identical input characters */
      while (j + k < len && data[j + k] == ch) { k++; runlen++; }

      /* Although matches are usually anchored at the end, in the case
         of extended runs of equal characters it is better to anchor after the
         first RABIN_WINDOW_SIZE bytes. This allows for quick skip ahead 
         while matching such runs, avoiding unneeded fingerprint calculations.
         Also, when anchoring at the end, matches will be generated after
         every word, because the fingerprint stays constant. Even though
         all matches would get combined during match optimization, 
         it wastes time and space.
      */
      if (runlen > maxlen[pch] + 4)
      { unsigned ofs;
        /* ofs points RABIN_WINDOW_SIZE bytes after the start of the run,
           rounded up to the next word */
        ofs = j + k - runlen + RABIN_WINDOW_SIZE + (sizeof (unsigned) - 1);
        ofs -= (ofs % sizeof (unsigned));
        maxofs [pch] = ofs;
        maxlen [pch] = runlen;
        assert (maxfp[pch] == 0 || maxfp[pch] == (unsigned) fp);
        maxfp [pch] = (unsigned) fp;
      }
      /* Keep input aligned as if no special run processing had taken place */
      j += k - (k % index_step) - index_step;
      k = index_step;
    }

    /* Testing showed that avoiding collisions using secondary hashing, or
       hash chaining had little effect and is not worth the time. */

    hash = ((unsigned) fp) & (idx_size - 1);
    idx [hash] = j + k;
  }

  /* Lastly, index the longest runs of equal characters found before.
     This ensures we always match the longerst such runs available.  */

  for (j = 0; j < 256; j++)
  { if (maxlen[j]) 
    { idx[maxfp[j] % idx_size] = maxofs[j];
} } }

static unsigned header_length (unsigned srclen, unsigned tgtlen)
{ unsigned len = 0;
  assert (srclen <= MAX_SIZE && tgtlen <= MAX_SIZE);

  /* GIT headers start with the length of the source and target,
     with 7 bits per byte, most significant byte first, and
     the high bit indicating continuation. */
  while (srclen >= 0x7f) { len++; srclen >>= 7; }
  while (tgtlen >= 0x7f) { len++; tgtlen >>= 7; }

  return len + 2;
}

static unsigned data_length (unsigned length)
{ assert (length > 0 && length <= MAX_SIZE);

  /* Can only include 0x7f data bytes per command */
  return (length / 0x7f) * 0x80 + length % 0x7f + 1;
}

static unsigned copy_length (unsigned offset, unsigned length)
{ /* Can only copy 0xffffff bytes per command. For longer commands,
     break into pieces of that size. It might be slightly more
     efficient to break into pieces of size 0xff0000, but it's not
     worth adding complexity for that rare case. */
  unsigned osize = !!(offset & 0xff) + !!(offset & 0xff00) 
                   + !!(offset & 0xff0000) + !!(offset & 0xff000000); 
  assert (offset < MAX_SIZE && length < MAX_SIZE);

  return 1 + (length / 0xffffff ) * (osize + 4) + osize +
           + !!(length & 0xff) + !!(length & 0xff00) + !!(length & 0xff0000);
}

static unsigned process_copies (unsigned char *data, unsigned length)
{ int j;
  unsigned ptr = length;
  unsigned patch_bytes = 0;

  /* Work through the copies backwards, extending each one backwards. */
  for (j = copy_count - 1; j >= 0; j--)
  { CopyInfo *copy = copies+j;
    unsigned src = copy->src;
    unsigned tgt = copy->tgt;
    unsigned len = copy->length;
    int data_follows;

    if (tgt + len > ptr)
    { /* Part of copy already covered by later one, so shorten copy. */

      if (ptr < tgt)
      {  /* Copy completely disappeared, but guess that a backward extension
            might still be useful. This extension is non-contiguous, as it is
            irrelevant whether the skipped data would have matched or not.
            Be careful to not extend past the beginning of the source. */
         unsigned adjust = tgt - ptr;

         tgt = ptr;
         src = (src < adjust) ? 0 : src - adjust;

         copy->tgt = tgt;
         copy->src = src;
      }
       
      len = ptr - tgt;
    }

    while (src && tgt && idx_data[src - 1] == data[tgt - 1])
    { src-- ; tgt--; }

    len += copy->tgt - tgt;

    data_follows = tgt + len < ptr;

    if (len < (data_follows ? 16 : 10)) len = 0;
    /* A short copy may cost as much as 6 bytes for the copy and
       5 as result of an extra data command.
       It's not worth having extra copies in order to just save a byte or two.
       Being too smart here may hurt later compression as well.
    */

    if (len && data_follows)
    { /* Some target data is not covered by the copies, account for
         the DATA command that will follow the copy. */
      patch_bytes += data_length (ptr - (tgt + len));
    }

    /* Everything about the copy is known and will not change.
       Write back the new information and update the patch size
       with the size of the copy instruction. */
    copy->length = len;
    copy->src = src;
    copy->tgt = tgt;

    /* Remove empty copies at end of list. */
    copy_count -= (!len && j == copy_count - 1);

    if (len)
    { /* update patch size for copy command */
      patch_bytes += copy_length (src, len);
      ptr = tgt;

  } }

  /* Account for data before first copy */
  for (j = 0; j < copy_count; j++)
  { if (copies[j].length)
    { if (copies[j].tgt) patch_bytes += data_length (copies[j].tgt);
      break;
  } }

  /* Case where no copies remain: entire file is a data statement. */
  if (!copy_count && length) patch_bytes += data_length (length);

  /* Account for header */
  patch_bytes += header_length (idx_data_len, length);

  return patch_bytes;
}

/* Match data against the current index and record all possible copies */
static int find_copies (unsigned char *data, size_t len)
{ size_t j = 0;
  u_int64_t fp = 0;

  unsigned w = 0; /* shift register for quick content verification */

  rabin_reset ();

  while (j < RABIN_WINDOW_SIZE && j < len)
  { unsigned char ch = data[j++];
    fp = rabin_slide (fp, ch);
    w = big_endian ? w<<8 | ch : w>>8 | ch<<((sizeof (w) - 1) * 8);
  }

  while (j < len) 
  { unsigned char ch = data[j++];
    unsigned hash, ofs;

    fp = rabin_slide (fp, ch);
    hash = fp & (idx_size - 1);
    ofs = idx[hash];

    w = big_endian ? w<<8 | ch : w>>8 | ch<<((sizeof (w) - 1) * 8);

    /* Invariant:
         data[0] .. data[j-1] has been processed
         w contains last sizeof (unsigned) bytes of processed data
         fp is fingerprint of sliding window ending at j-1
         ofs is zero or points just past tentative match
         ofs is a multiple of index_step
    */

    if (ofs && *((unsigned *) (idx_data + ofs - sizeof (w))) == w)
    { /* Found a match. Now try to extend it forward. */
      unsigned runlen = sizeof (w);
      unsigned tgt = j - runlen;
      unsigned src = ofs - runlen;
      unsigned maxrun = MIN (idx_data_len - src, len - tgt);
      CopyInfo *copy;

      if (copy_count == max_copies)
      { max_copies *= 2;
        if (!max_copies)
        { max_copies = MAX_COPIES;
          copies = malloc(max_copies * sizeof (CopyInfo));
        }
        else
        { copies = realloc(copies, max_copies * sizeof (CopyInfo));
        }

        if (!copies) return 0;
      }

      copy = copies + copy_count;

      /* Hot loop */
      while (runlen < maxrun && data[tgt + runlen] == idx_data[src + runlen])
      { runlen++; }

      copy->src = src;
      copy->tgt = tgt;
      copy->length = runlen;
      copy_count++;

      /* For runs extending more than RABIN_WINDOW_SIZE bytes beyond j,
         skip ahead to prevent useless fingerprint computations. */
      if (tgt + runlen > j + RABIN_WINDOW_SIZE)
      { j = tgt  + runlen - RABIN_WINDOW_SIZE;
      }

      /* Quickly scan ahead without looking for matches
         until the end of this run */

      while (j + sizeof (w) < tgt + runlen) fp = rabin_slide (fp, data[j++]);

      while (j < tgt + runlen)
      { unsigned char ch = data[j++];
        fp = rabin_slide (fp, ch);

        w = big_endian ? w<<8 | ch : w>>8 | ch<<((sizeof (w) - 1) * 8);
  } } }

  return 1;
}

unsigned calculate_delta (void *to_buf, unsigned long to_size)
{ unsigned delta_size;

  assert (to_size < MAX_SIZE);

  if (!find_copies ((unsigned char *) to_buf, to_size)) return 0;
  delta_size = process_copies ((unsigned char *) to_buf, to_size);

  return delta_size;
}

static unsigned char *
write_header (unsigned char *patch, unsigned srclen, unsigned tgtlen)
{ 
  assert (srclen <= MAX_SIZE && tgtlen <= MAX_SIZE);

  while (srclen >= 0x7f) 
  { *patch++= (srclen & 0x7f) | 0x80;
    srclen >>= 7; 
  }
  *patch++ = srclen;
  while (tgtlen >= 0x7f)
  { *patch++ = (tgtlen & 0x7f) | 0x80;
    tgtlen >>= 7;
  }
  *patch++ = tgtlen;

  return patch;
}

static unsigned char *
write_data (unsigned char *patch, unsigned char *data, unsigned size)
{ assert (size > 0 && size < MAX_SIZE);
  /* The return value must be equal to patch + data_length (patch, size).
     This correspondence is essential for calculating the patch size.  */

  /* GIT has no data commands for large data, rest is same as GDIFF */
  while (size > 0x7f)
  { *patch++ = (unsigned char) 0x7f;
    memcpy (patch, data, 0x7f);
    data += 0x7f;
    patch += 0x7f;
    size -= 0x7f;
  }

  *patch++ = (unsigned char) size; 
  memcpy (patch, data, size);

  return patch + size;
} 

static unsigned char *
write_copy (unsigned char *patch, unsigned offset, unsigned size)
{ /* The return value must be equal to patch + copy_length (patch,offset,size).
     This correspondence is essential for calculating the patch size.  */

  while (size > 0)
  { unsigned chunksize = MIN (0xffffff, size);
    unsigned char cmd = 1;
    cmd = (cmd<<1) | !!(size & 0xff0000);
    cmd = (cmd<<1) | !!(size & 0x00ff00);
    cmd = (cmd<<1) | !!(size & 0x0000ff); 
    cmd = (cmd<<1) | !!(offset & 0xff000000);
    cmd = (cmd<<1) | !!(offset & 0x00ff0000);
    cmd = (cmd<<1) | !!(offset & 0x0000ff00);
    cmd = (cmd<<1) | !!(offset & 0x000000ff);
    *patch++ = cmd | 0x80;
    if (cmd & 0x01) *patch++ = offset & 0xff;
    if (cmd & 0x02) *patch++ = (offset >> 8) & 0xff;
    if (cmd & 0x04) *patch++ = (offset >> 16) & 0xff;
    if (cmd & 0x08) *patch++ = (offset >> 24) & 0xff;
    if (cmd & 0x10) *patch++ = size & 0xff;
    if (cmd & 0x20) *patch++ = (size >> 8) & 0xff;
    if (cmd & 0x40) *patch++ = (size >> 16) & 0xff;
    size -= chunksize;
  } 
  return patch;
} 

void*
create_delta (unsigned char *data, unsigned len, unsigned delta_size)
{ unsigned char *delta = (unsigned char *) malloc (delta_size);
  unsigned char *ptr = delta;
  unsigned offset = 0;
  unsigned data_commands = 0;
  unsigned copy_commands = 0;
  int j;

  ptr = write_header (ptr, idx_data_len, len);

  for (j = 0; j < copy_count; j++)
  { CopyInfo *copy = copies + j;
    unsigned copylen = copy->length;

    if (copylen)
    { if (copy->tgt > offset)
      { assert (delta_size - (ptr - delta) > data_length (copy->tgt - offset));
        ptr = write_data (ptr, data + offset, copy->tgt - offset);
        data_commands++;
      }

      assert (delta_size - (ptr - delta) >= copy_length (copy->src, copylen));

      ptr = write_copy (ptr, copy->src, copylen);
      copy_commands++;
      offset = copy->tgt + copylen;
  } }

  if (offset < len)
  { assert (delta_size - (ptr - delta) >= data_length (len - offset));
    ptr = write_data (ptr, data + offset, len - offset);
    data_commands++;
  }
  assert (ptr - delta == (int) delta_size);

  return delta;
}

void *diff_delta(void *from_buf, unsigned long from_size,
                 void *to_buf, unsigned long to_size,
                 unsigned long *delta_size, unsigned long max_size)
{ unsigned dsize;
  assert (from_size <= MAX_SIZE && to_size <= MAX_SIZE);
  init_idx (from_buf, from_size, 1); /* Use optimization level 1 */
  dsize = calculate_delta (to_buf, to_size);
  if (!dsize) return 0;
  *delta_size = dsize;
  return create_delta (to_buf, to_size, *delta_size);
}

--Apple-Mail-3--156753544--
