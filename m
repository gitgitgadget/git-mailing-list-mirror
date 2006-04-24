From: Nicolas Pitre <nico@cam.org>
Subject: Re: RFC: New diff-delta.c implementation
Date: Mon, 24 Apr 2006 01:27:07 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0604232327500.3603@localhost.localdomain>
References: <602974A9-09A3-46E9-92D6-D30728923C11@adacore.com>
 <444A2334.3030501@lsrfire.ath.cx> <20060424025741.GA636@adacore.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_5MH4IoU+bG7DXQp2bcVLsw)"
Cc: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 24 07:27:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXtbP-0006Qb-Jm
	for gcvg-git@gmane.org; Mon, 24 Apr 2006 07:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWDXF1M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Apr 2006 01:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWDXF1L
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Apr 2006 01:27:11 -0400
Received: from relais.videotron.ca ([24.201.245.36]:2851 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1750701AbWDXF1K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Apr 2006 01:27:10 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IY700GDOOH78K50@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 24 Apr 2006 01:27:09 -0400 (EDT)
In-reply-to: <20060424025741.GA636@adacore.com>
X-X-Sender: nico@localhost.localdomain
To: Geert Bosch <bosch@adacore.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19089>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_5MH4IoU+bG7DXQp2bcVLsw)
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT

On Sun, 23 Apr 2006, Geert Bosch wrote:

> Note that I sent this code as a RFC, with explicit disclaimers about
> style.

I took the liberty of reworking the coding style, as well as simplifying 
some constructs a bit.

I also fixed all the format encoding and size computations bugs the 
original code has so it works perfectly now.

> So, I did not want to sign off on this code, since I pretty
> much knew there would be some problems with the undocumented
> ("proprietary", according the libxdiff site) file format. In contrast
> the GDIFF fileformat was documented very well, and I have a version
> of this code that works flawlessly with that format.

Note that the GIT encoding is itself different (a bit denser) from the 
xdiff encoding.

> > Regarding your FIXME comment about endianess: I think you are looking
> > for htonl().  Use it to convert the values from host byte order to
> > network byte order (= big endian) and you can get rid of those ugly
> > branches.
> Ah, I'll use that. It's of course a slight change that all processing
> now is big-endian centric, but that might actually even result in
> better code in this case. I'm just assuming any decent system has
> some highly optimized macro for this and will never do a function call.
> This is used in the most performance critical loops, and doing function
> calls here will lead to horrendous performance.

Please just completely drop that word fetch "optimization".  Not only 
does it produce worse assembly code in the end due to the extra loop 
counter and extra shifting in turn increasing register pressure, but it 
also assumes that the target data buffer is always word aligned which is 
not guaranteed (casting a char pointer to an unsigned and dereferencing 
it is not portable since on some architecture such misaligned accesses 
are not allowed).  And it even has worse performance.  For example, with 
word fetch and shift code, packing the Linux kernel archive on my P4 at 
3GHz:

$ git-repack -a -f
...
real    7m5.727s
user    6m33.797s
sys     0m31.394s

And with the word fetch optimization completely ripped out:

$ git-repack -a -f
...
real    6m45.443s
user    6m13.911s
sys     0m31.434s

So you must be extremely careful when trying to implement such kind of 
optimizations.

Now disabling all assert() statements gives:

$ git-repack -a -f
...
real    6m42.478s
user    6m12.031s
sys     0m31.090s

But here comes the sad part.  Even after simplifying the code as much as 
I could, performance is still significantly worse than the current 
diff-delta.c code.  Repacking again the same Linux kernel repository 
with the current code:

$ git-repack -a -f
...
real    4m20.742s
user    3m52.255s
sys     0m28.758s

The final pack is smaller with your code but not significantly: 
117867049 bytes vs 118824550 bytes with the current code, i.e. less than 
1% difference.

You can find attached my current version of your code.

In the mean time I'll try replacing the adler32 hashing with your Rabin 
polynomial hashing into the current code just to see if it helps (and I 
think it will help quite a bit).  The best solution might be a mix of 
both approaches.

Of course there is the issue of reversing the object matching window 
logic in pack-object.c to further improve things, but I consider that an 
orthogonal improvement at this point which both approaches will benefit 
from anyway.


Nicolas

--Boundary_(ID_5MH4IoU+bG7DXQp2bcVLsw)
Content-id: <Pine.LNX.4.64.0604240127070.3603@localhost.localdomain>
Content-type: TEXT/PLAIN; charset=US-ASCII; name=diff-delta.c
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=diff-delta.c
Content-description:

#include <unistd.h>

#include <stdlib.h>

#include <assert.h>

#include <string.h>

#include <sys/types.h>



#undef assert

#define assert(x) do { } while (0)



/*

 * MIN_HTAB_SIZE is fixed amount to be added to the size of the hash table

 * used for indexing and must be a power of two. This allows for small files

 * to have a sparse hash table, since in that case it's cheap.

 * Hash table sizes are rounded up to a power of two to avoid integer division. 

 */

#define MIN_HTAB_SIZE 8192

#define MAX_HTAB_SIZE (1024*1024*1024)



/*

 * Diffing files of gigabyte range is impractical with the current

 * algorithm, so we're assuming 32-bit sizes everywhere.

 * Size leaves some room for expansion when diffing random files.

 */

#define MAX_SIZE (0x7eff0000)



/* Initial size of copies table, dynamically extended as needed. */

#define MAX_COPIES 4096



/*

 * Matching is done using a sliding window for which a Rabin

 * polynomial is computed. The advantage of such polynomials is

 * that they can efficiently be updated at every position.

 * The tables needed for this are precomputed, as it is desirable

 * to use the same polynomial all the time for repeatable results.

 */



#if 0	/* those don't seem to work */



#define RABIN_POLY 0x25bd5331c0d7096dULL

#define RABIN_DEGREE 61

#define RABIN_SHIFT 53

#define RABIN_WINDOW_SIZE 22



static const u_int64_t T[256] = {

	0x6ec7f55241791bb7ULL, 0x96f54cc7035c25b4ULL, 0xb3481ff6c38b2cd9ULL,

	0xdd8feaa482f2376eULL, 0xf832b99542253e03ULL, 0x0857cabfc66f4205ULL,

	0x2dea998e06b84b68ULL, 0x432d6cdc47c150dfULL, 0x66903fed871659b2ULL,

	0x9ea28678c53367b1ULL, 0xbb1fd54905e46edcULL, 0xd5d8201b449d756bULL,

	0xf065732a844a7c06ULL, 0x10af957f8cde840aULL, 0x3512c64e4c098d67ULL,

	0x5bd5331c0d7096d0ULL, 0x7e68602dcda79fbdULL, 0x865ad9b88f82a1beULL,

	0xa3e78a894f55a8d3ULL, 0xcd207fdb0e2cb364ULL, 0xe89d2ceacefbba09ULL,

	0x18f85fc04ab1c60fULL, 0x3d450cf18a66cf62ULL, 0x5382f9a3cb1fd4d5ULL,

	0x763faa920bc8ddb8ULL, 0x8e0d130749ede3bbULL, 0xabb04036893aead6ULL,

	0xc577b564c843f161ULL, 0xe0cae6550894f80cULL, 0x04e279ced96a0179ULL,

	0x215f2aff19bd0814ULL, 0x4f98dfad58c413a3ULL, 0x6a258c9c98131aceULL,

	0x92173509da3624cdULL, 0xb7aa66381ae12da0ULL, 0xd96d936a5b983617ULL,

	0xfcd0c05b9b4f3f7aULL, 0x0cb5b3711f05437cULL, 0x2908e040dfd24a11ULL,

	0x47cf15129eab51a6ULL, 0x627246235e7c58cbULL, 0x9a40ffb61c5966c8ULL,

	0xbffdac87dc8e6fa5ULL, 0xd13a59d59df77412ULL, 0xf4870ae45d207d7fULL,

	0x144decb155b48573ULL, 0x31f0bf8095638c1eULL, 0x5f374ad2d41a97a9ULL,

	0x7a8a19e314cd9ec4ULL, 0x82b8a07656e8a0c7ULL, 0xa705f347963fa9aaULL,

	0xc9c20615d746b21dULL, 0xec7f55241791bb70ULL, 0x1c1a260e93dbc776ULL,

	0x39a7753f530cce1bULL, 0x5760806d1275d5acULL, 0x72ddd35cd2a2dcc1ULL,

	0x8aef6ac99087e2c2ULL, 0xaf5239f85050ebafULL, 0xc195ccaa1129f018ULL,

	0xe4289f9bd1fef975ULL, 0x09c4f39db2d402f2ULL, 0x2c79a0ac72030b9fULL,

	0x42be55fe337a1028ULL, 0x670306cff3ad1945ULL, 0x9f31bf5ab1882746ULL,

	0xba8cec6b715f2e2bULL, 0xd44b19393026359cULL, 0xf1f64a08f0f13cf1ULL,

	0x0193392274bb40f7ULL, 0x242e6a13b46c499aULL, 0x4ae99f41f515522dULL,

	0x6f54cc7035c25b40ULL, 0x976675e577e76543ULL, 0xb2db26d4b7306c2eULL,

	0xdc1cd386f6497799ULL, 0xf9a180b7369e7ef4ULL, 0x196b66e23e0a86f8ULL,

	0x3cd635d3fedd8f95ULL, 0x5211c081bfa49422ULL, 0x77ac93b07f739d4fULL,

	0x8f9e2a253d56a34cULL, 0xaa237914fd81aa21ULL, 0xc4e48c46bcf8b196ULL,

	0xe159df777c2fb8fbULL, 0x113cac5df865c4fdULL, 0x3481ff6c38b2cd90ULL,

	0x5a460a3e79cbd627ULL, 0x7ffb590fb91cdf4aULL, 0x87c9e09afb39e149ULL,

	0xa274b3ab3beee824ULL, 0xccb346f97a97f393ULL, 0xe90e15c8ba40fafeULL,

	0x0d268a536bbe038bULL, 0x289bd962ab690ae6ULL, 0x465c2c30ea101151ULL,

	0x63e17f012ac7183cULL, 0x9bd3c69468e2263fULL, 0xbe6e95a5a8352f52ULL,

	0xd0a960f7e94c34e5ULL, 0xf51433c6299b3d88ULL, 0x057140ecadd1418eULL,

	0x20cc13dd6d0648e3ULL, 0x4e0be68f2c7f5354ULL, 0x6bb6b5beeca85a39ULL,

	0x93840c2bae8d643aULL, 0xb6395f1a6e5a6d57ULL, 0xd8feaa482f2376e0ULL,

	0xfd43f979eff47f8dULL, 0x1d891f2ce7608781ULL, 0x38344c1d27b78eecULL,

	0x56f3b94f66ce955bULL, 0x734eea7ea6199c36ULL, 0x8b7c53ebe43ca235ULL,

	0xaec100da24ebab58ULL, 0xc006f5886592b0efULL, 0xe5bba6b9a545b982ULL,

	0x15ded593210fc584ULL, 0x306386a2e1d8cce9ULL, 0x5ea473f0a0a1d75eULL,

	0x7b1920c16076de33ULL, 0x832b99542253e030ULL, 0xa696ca65e284e95dULL,

	0xc8513f37a3fdf2eaULL, 0xedec6c06632afb87ULL, 0x1389e73b65a805e4ULL,

	0x3634b40aa57f0c89ULL, 0x58f34158e406173eULL, 0x7d4e126924d11e53ULL,

	0x857cabfc66f42050ULL, 0xa0c1f8cda623293dULL, 0xce060d9fe75a328aULL,

	0xebbb5eae278d3be7ULL, 0x1bde2d84a3c747e1ULL, 0x3e637eb563104e8cULL,

	0x50a48be72269553bULL, 0x7519d8d6e2be5c56ULL, 0x8d2b6143a09b6255ULL,

	0xa8963272604c6b38ULL, 0xc651c7202135708fULL, 0xe3ec9411e1e279e2ULL,

	0x03267244e97681eeULL, 0x269b217529a18883ULL, 0x485cd42768d89334ULL,

	0x6de18716a80f9a59ULL, 0x95d33e83ea2aa45aULL, 0xb06e6db22afdad37ULL,

	0xdea998e06b84b680ULL, 0xfb14cbd1ab53bfedULL, 0x0b71b8fb2f19c3ebULL,

	0x2eccebcaefceca86ULL, 0x400b1e98aeb7d131ULL, 0x65b64da96e60d85cULL,

	0x9d84f43c2c45e65fULL, 0xb839a70dec92ef32ULL, 0xd6fe525fadebf485ULL,

	0xf343016e6d3cfde8ULL, 0x176b9ef5bcc2049dULL, 0x32d6cdc47c150df0ULL,

	0x5c1138963d6c1647ULL, 0x79ac6ba7fdbb1f2aULL, 0x819ed232bf9e2129ULL,

	0xa42381037f492844ULL, 0xcae474513e3033f3ULL, 0xef592760fee73a9eULL,

	0x1f3c544a7aad4698ULL, 0x3a81077bba7a4ff5ULL, 0x5446f229fb035442ULL,

	0x71fba1183bd45d2fULL, 0x89c9188d79f1632cULL, 0xac744bbcb9266a41ULL,

	0xc2b3beeef85f71f6ULL, 0xe70eeddf3888789bULL, 0x07c40b8a301c8097ULL,

	0x227958bbf0cb89faULL, 0x4cbeade9b1b2924dULL, 0x6903fed871659b20ULL,

	0x9131474d3340a523ULL, 0xb48c147cf397ac4eULL, 0xda4be12eb2eeb7f9ULL,

	0xfff6b21f7239be94ULL, 0x0f93c135f673c292ULL, 0x2a2e920436a4cbffULL,

	0x44e9675677ddd048ULL, 0x61543467b70ad925ULL, 0x99668df2f52fe726ULL,

	0xbcdbdec335f8ee4bULL, 0xd21c2b917481f5fcULL, 0xf7a178a0b456fc91ULL,

	0x1a4d14a6d77c0716ULL, 0x3ff0479717ab0e7bULL, 0x5137b2c556d215ccULL,

	0x748ae1f496051ca1ULL, 0x8cb85861d42022a2ULL, 0xa9050b5014f72bcfULL,

	0xc7c2fe02558e3078ULL, 0xe27fad3395593915ULL, 0x121ade1911134513ULL,

	0x37a78d28d1c44c7eULL, 0x5960787a90bd57c9ULL, 0x7cdd2b4b506a5ea4ULL,

	0x84ef92de124f60a7ULL, 0xa152c1efd29869caULL, 0xcf9534bd93e1727dULL,

	0xea28678c53367b10ULL, 0x0ae281d95ba2831cULL, 0x2f5fd2e89b758a71ULL,

	0x419827bada0c91c6ULL, 0x6425748b1adb98abULL, 0x9c17cd1e58fea6a8ULL,

	0xb9aa9e2f9829afc5ULL, 0xd76d6b7dd950b472ULL, 0xf2d0384c1987bd1fULL,

	0x02b54b669dcdc119ULL, 0x270818575d1ac874ULL, 0x49cfed051c63d3c3ULL,

	0x6c72be34dcb4daaeULL, 0x944007a19e91e4adULL, 0xb1fd54905e46edc0ULL,

	0xdf3aa1c21f3ff677ULL, 0xfa87f2f3dfe8ff1aULL, 0x1eaf6d680e16066fULL,

	0x3b123e59cec10f02ULL, 0x55d5cb0b8fb814b5ULL, 0x7068983a4f6f1dd8ULL,

	0x885a21af0d4a23dbULL, 0xade7729ecd9d2ab6ULL, 0xc32087cc8ce43101ULL,

	0xe69dd4fd4c33386cULL, 0x16f8a7d7c879446aULL, 0x3345f4e608ae4d07ULL,

	0x5d8201b449d756b0ULL, 0x783f528589005fddULL, 0x800deb10cb2561deULL,

	0xa5b0b8210bf268b3ULL, 0xcb774d734a8b7304ULL, 0xeeca1e428a5c7a69ULL,

	0x0e00f81782c88265ULL, 0x2bbdab26421f8b08ULL, 0x457a5e74036690bfULL,

	0x60c70d45c3b199d2ULL, 0x98f5b4d08194a7d1ULL, 0xbd48e7e14143aebcULL,

	0xd38f12b3003ab50bULL, 0xf6324182c0edbc66ULL, 0x065732a844a7c060ULL,

	0x23ea61998470c90dULL, 0x4d2d94cbc509d2baULL, 0x6890c7fa05dedbd7ULL,

	0x90a27e6f47fbe5d4ULL, 0xb51f2d5e872cecb9ULL, 0xdbd8d80cc655f70eULL,

	0xfe658b3d0682fe63ULL

};



static const u_int64_t U[256] = {

	0x0000000000000000ULL, 0x067b86c43d6a6cb0ULL, 0x0cf70d887ad4d960ULL,

	0x0a8c8b4c47beb5d0ULL, 0x19ee1b10f5a9b2c0ULL, 0x1f959dd4c8c3de70ULL,

	0x151916988f7d6ba0ULL, 0x1362905cb2170710ULL, 0x166165102b846cedULL,

	0x101ae3d416ee005dULL, 0x1a9668985150b58dULL, 0x1cedee5c6c3ad93dULL,

	0x0f8f7e00de2dde2dULL, 0x09f4f8c4e347b29dULL, 0x03787388a4f9074dULL,

	0x0503f54c99936bfdULL, 0x097f991197dfd0b7ULL, 0x0f041fd5aab5bc07ULL,

	0x05889499ed0b09d7ULL, 0x03f3125dd0616567ULL, 0x1091820162766277ULL,

	0x16ea04c55f1c0ec7ULL, 0x1c668f8918a2bb17ULL, 0x1a1d094d25c8d7a7ULL,

	0x1f1efc01bc5bbc5aULL, 0x19657ac58131d0eaULL, 0x13e9f189c68f653aULL,

	0x1592774dfbe5098aULL, 0x06f0e71149f20e9aULL, 0x008b61d57498622aULL,

	0x0a07ea993326d7faULL, 0x0c7c6c5d0e4cbb4aULL, 0x12ff32232fbfa16eULL,

	0x1484b4e712d5cddeULL, 0x1e083fab556b780eULL, 0x1873b96f680114beULL,

	0x0b112933da1613aeULL, 0x0d6aaff7e77c7f1eULL, 0x07e624bba0c2caceULL,

	0x019da27f9da8a67eULL, 0x049e5733043bcd83ULL, 0x02e5d1f73951a133ULL,

	0x08695abb7eef14e3ULL, 0x0e12dc7f43857853ULL, 0x1d704c23f1927f43ULL,

	0x1b0bcae7ccf813f3ULL, 0x118741ab8b46a623ULL, 0x17fcc76fb62cca93ULL,

	0x1b80ab32b86071d9ULL, 0x1dfb2df6850a1d69ULL, 0x1777a6bac2b4a8b9ULL,

	0x110c207effdec409ULL, 0x026eb0224dc9c319ULL, 0x041536e670a3afa9ULL,

	0x0e99bdaa371d1a79ULL, 0x08e23b6e0a7776c9ULL, 0x0de1ce2293e41d34ULL,

	0x0b9a48e6ae8e7184ULL, 0x0116c3aae930c454ULL, 0x076d456ed45aa8e4ULL,

	0x140fd532664daff4ULL, 0x127453f65b27c344ULL, 0x18f8d8ba1c997694ULL,

	0x1e835e7e21f31a24ULL, 0x004337779fa84bb1ULL, 0x0638b1b3a2c22701ULL,

	0x0cb43affe57c92d1ULL, 0x0acfbc3bd816fe61ULL, 0x19ad2c676a01f971ULL,

	0x1fd6aaa3576b95c1ULL, 0x155a21ef10d52011ULL, 0x1321a72b2dbf4ca1ULL,

	0x16225267b42c275cULL, 0x1059d4a389464becULL, 0x1ad55fefcef8fe3cULL,

	0x1caed92bf392928cULL, 0x0fcc49774185959cULL, 0x09b7cfb37ceff92cULL,

	0x033b44ff3b514cfcULL, 0x0540c23b063b204cULL, 0x093cae6608779b06ULL,

	0x0f4728a2351df7b6ULL, 0x05cba3ee72a34266ULL, 0x03b0252a4fc92ed6ULL,

	0x10d2b576fdde29c6ULL, 0x16a933b2c0b44576ULL, 0x1c25b8fe870af0a6ULL,

	0x1a5e3e3aba609c16ULL, 0x1f5dcb7623f3f7ebULL, 0x19264db21e999b5bULL,

	0x13aac6fe59272e8bULL, 0x15d1403a644d423bULL, 0x06b3d066d65a452bULL,

	0x00c856a2eb30299bULL, 0x0a44ddeeac8e9c4bULL, 0x0c3f5b2a91e4f0fbULL,

	0x12bc0554b017eadfULL, 0x14c783908d7d866fULL, 0x1e4b08dccac333bfULL,

	0x18308e18f7a95f0fULL, 0x0b521e4445be581fULL, 0x0d29988078d434afULL,

	0x07a513cc3f6a817fULL, 0x01de95080200edcfULL, 0x04dd60449b938632ULL,

	0x02a6e680a6f9ea82ULL, 0x082a6dcce1475f52ULL, 0x0e51eb08dc2d33e2ULL,

	0x1d337b546e3a34f2ULL, 0x1b48fd9053505842ULL, 0x11c476dc14eeed92ULL,

	0x17bff01829848122ULL, 0x1bc39c4527c83a68ULL, 0x1db81a811aa256d8ULL,

	0x173491cd5d1ce308ULL, 0x114f170960768fb8ULL, 0x022d8755d26188a8ULL,

	0x04560191ef0be418ULL, 0x0eda8adda8b551c8ULL, 0x08a10c1995df3d78ULL,

	0x0da2f9550c4c5685ULL, 0x0bd97f9131263a35ULL, 0x0155f4dd76988fe5ULL,

	0x072e72194bf2e355ULL, 0x144ce245f9e5e445ULL, 0x12376481c48f88f5ULL,

	0x18bbefcd83313d25ULL, 0x1ec06909be5b5195ULL, 0x00866eef3f509762ULL,

	0x06fde82b023afbd2ULL, 0x0c71636745844e02ULL, 0x0a0ae5a378ee22b2ULL,

	0x196875ffcaf925a2ULL, 0x1f13f33bf7934912ULL, 0x159f7877b02dfcc2ULL,

	0x13e4feb38d479072ULL, 0x16e70bff14d4fb8fULL, 0x109c8d3b29be973fULL,

	0x1a1006776e0022efULL, 0x1c6b80b3536a4e5fULL, 0x0f0910efe17d494fULL,

	0x0972962bdc1725ffULL, 0x03fe1d679ba9902fULL, 0x05859ba3a6c3fc9fULL,

	0x09f9f7fea88f47d5ULL, 0x0f82713a95e52b65ULL, 0x050efa76d25b9eb5ULL,

	0x03757cb2ef31f205ULL, 0x1017ecee5d26f515ULL, 0x166c6a2a604c99a5ULL,

	0x1ce0e16627f22c75ULL, 0x1a9b67a21a9840c5ULL, 0x1f9892ee830b2b38ULL,

	0x19e3142abe614788ULL, 0x136f9f66f9dff258ULL, 0x151419a2c4b59ee8ULL,

	0x067689fe76a299f8ULL, 0x000d0f3a4bc8f548ULL, 0x0a8184760c764098ULL,

	0x0cfa02b2311c2c28ULL, 0x12795ccc10ef360cULL, 0x1402da082d855abcULL,

	0x1e8e51446a3bef6cULL, 0x18f5d780575183dcULL, 0x0b9747dce54684ccULL,

	0x0decc118d82ce87cULL, 0x07604a549f925dacULL, 0x011bcc90a2f8311cULL,

	0x041839dc3b6b5ae1ULL, 0x0263bf1806013651ULL, 0x08ef345441bf8381ULL,

	0x0e94b2907cd5ef31ULL, 0x1df622cccec2e821ULL, 0x1b8da408f3a88491ULL,

	0x11012f44b4163141ULL, 0x177aa980897c5df1ULL, 0x1b06c5dd8730e6bbULL,

	0x1d7d4319ba5a8a0bULL, 0x17f1c855fde43fdbULL, 0x118a4e91c08e536bULL,

	0x02e8decd7299547bULL, 0x049358094ff338cbULL, 0x0e1fd345084d8d1bULL,

	0x086455813527e1abULL, 0x0d67a0cdacb48a56ULL, 0x0b1c260991dee6e6ULL,

	0x0190ad45d6605336ULL, 0x07eb2b81eb0a3f86ULL, 0x1489bbdd591d3896ULL,

	0x12f23d1964775426ULL, 0x187eb65523c9e1f6ULL, 0x1e0530911ea38d46ULL,

	0x00c55998a0f8dcd3ULL, 0x06bedf5c9d92b063ULL, 0x0c325410da2c05b3ULL,

	0x0a49d2d4e7466903ULL, 0x192b428855516e13ULL, 0x1f50c44c683b02a3ULL,

	0x15dc4f002f85b773ULL, 0x13a7c9c412efdbc3ULL, 0x16a43c888b7cb03eULL,

	0x10dfba4cb616dc8eULL, 0x1a533100f1a8695eULL, 0x1c28b7c4ccc205eeULL,

	0x0f4a27987ed502feULL, 0x0931a15c43bf6e4eULL, 0x03bd2a100401db9eULL,

	0x05c6acd4396bb72eULL, 0x09bac08937270c64ULL, 0x0fc1464d0a4d60d4ULL,

	0x054dcd014df3d504ULL, 0x03364bc57099b9b4ULL, 0x1054db99c28ebea4ULL,

	0x162f5d5dffe4d214ULL, 0x1ca3d611b85a67c4ULL, 0x1ad850d585300b74ULL,

	0x1fdba5991ca36089ULL, 0x19a0235d21c90c39ULL, 0x132ca8116677b9e9ULL,

	0x15572ed55b1dd559ULL, 0x0635be89e90ad249ULL, 0x004e384dd460bef9ULL,

	0x0ac2b30193de0b29ULL, 0x0cb935c5aeb46799ULL, 0x123a6bbb8f477dbdULL,

	0x1441ed7fb22d110dULL, 0x1ecd6633f593a4ddULL, 0x18b6e0f7c8f9c86dULL,

	0x0bd470ab7aeecf7dULL, 0x0daff66f4784a3cdULL, 0x07237d23003a161dULL,

	0x0158fbe73d507aadULL, 0x045b0eaba4c31150ULL, 0x0220886f99a97de0ULL,

	0x08ac0323de17c830ULL, 0x0ed785e7e37da480ULL, 0x1db515bb516aa390ULL,

	0x1bce937f6c00cf20ULL, 0x114218332bbe7af0ULL, 0x17399ef716d41640ULL,

	0x1b45f2aa1898ad0aULL, 0x1d3e746e25f2c1baULL, 0x17b2ff22624c746aULL,

	0x11c979e65f2618daULL, 0x02abe9baed311fcaULL, 0x04d06f7ed05b737aULL,

	0x0e5ce43297e5c6aaULL, 0x082762f6aa8faa1aULL, 0x0d2497ba331cc1e7ULL,

	0x0b5f117e0e76ad57ULL, 0x01d39a3249c81887ULL, 0x07a81cf674a27437ULL,

	0x14ca8caac6b57327ULL, 0x12b10a6efbdf1f97ULL, 0x183d8122bc61aa47ULL,

	0x1e4607e6810bc6f7ULL

};



#else	/* the original ones */



#define RABIN_WINDOW_SIZE 22

#define RABIN_SHIFT 55



static const u_int64_t T[256] = {

	0x0000000000000000ULL, 0xb15e234bd3792f63ULL, 0x62bc4697a6f25ec6ULL,

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



static const u_int64_t U[256] = {

	0x0000000000000000ULL, 0x079343d61ab9f60eULL, 0x0f2687ac3573ec1cULL,

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



#endif



static unsigned char rabin_window[RABIN_WINDOW_SIZE];

static unsigned rabin_pos = 0;



#define MIN(x,y) ((y)<(x) ? (y) : (x))

#define MAX(x,y) ((y)>(x) ? (y) : (x))



/*

 * The copies array is the central data structure for diff generation.

 * Data statements are implicit, for ranges not covered by any copy command.

 *

 * The sum of tgt and length for each entry must be monotonically increasing,

 * and data ranges must be non-overlapping. This is accomplished by not

 * extending matches backwards during initial matching.

 *

 * Copies may have zero length, to make it quick to delete copies during

 * optimization. However, the last copy in the list must always be a

 * non-trivial copy.

 *

 * Before committing copies, an important optimization is performed: during 

 * a backward pass through the copies array, each entry is extended backwards,

 * and redundant copies are eliminated.

 *

 * If each match were extended backwards on insertion, the same data may be

 * matched an arbitrary number of times, resulting in potentially quadratic

 * time behavior.

 */



typedef struct copyinfo {

	unsigned src;

	unsigned tgt;

	unsigned length;

} CopyInfo;



static CopyInfo *copies;

static int copy_count = 0;

static unsigned max_copies = 0; /* Dynamically increased */



static unsigned *idx;

static unsigned idx_size;

static unsigned char *idx_data;

static unsigned idx_data_len;



static void rabin_reset(void)

{

	memset(rabin_window, 0, sizeof(rabin_window));

}



static u_int64_t rabin_slide (u_int64_t fp, unsigned char m)

{

	unsigned char om;

	if (++rabin_pos == RABIN_WINDOW_SIZE) rabin_pos = 0;

	om = rabin_window[rabin_pos];

	fp ^= U[om];

	rabin_window[rabin_pos] = m;

	fp = ((fp << 8) | m) ^ T[fp >> RABIN_SHIFT];

	return fp;

}



static void init_idx (unsigned char *data, size_t len, int level)

{

	unsigned index_step = RABIN_WINDOW_SIZE / sizeof(unsigned) * sizeof(unsigned);

	size_t j, k;

	unsigned char ch = 0;

	unsigned maxofs[256];

	unsigned maxlen[256];

	unsigned maxfp[256];

	unsigned runlen = 0;

	u_int64_t fp = 0;



	assert (len <= MAX_SIZE);

	assert (level >= 0 && level <= 9);

	memset(maxofs, 0, sizeof(maxofs));

	memset(maxlen, 0, sizeof(maxlen));

	memset(maxfp, 0, sizeof(maxfp));



	/* index_step must be multiple of word size */

	if (level >= 1)

		index_step = MIN(index_step, 4 * sizeof(unsigned));

	/* Use smaller step size for higher optimization levels or smaller files */

	if (level >= 3 || len <= 65536)

		index_step = MIN (index_step, 3 * sizeof (unsigned));

	if (level >= 4 || len <= 32768)

		index_step = MIN (index_step, 2 * sizeof (unsigned));

	if (level >= 6 || len < 16384)

		index_step = MIN (index_step, 1 * sizeof (unsigned));

	assert (index_step && !(index_step % sizeof (unsigned)));



	/* Add fixed amount to hash table size, as small files will benefit

	   a lot without using significantly more memory or time. */

	idx_size = (level + 1) * (len / index_step) / 2 + MIN_HTAB_SIZE;

	idx_size = MIN (idx_size, MAX_HTAB_SIZE - 1); /* So rounding up works */



	/* Round up to next power of two, but limit to MAX_HTAB_SIZE. */

	{

		unsigned s = MIN_HTAB_SIZE;

		while (s < idx_size) s += s;

		idx_size = s;

	}



	idx_data = data;

	idx_data_len = len;

	idx = calloc(idx_size, sizeof(unsigned)); 



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



	for (j = 0; j + index_step < len; j += index_step) {

		unsigned char pch = 0;

		unsigned hash;



		for (k = 0; k < index_step; k++) {

			pch = ch;

			ch = data[j + k];

			if (ch != pch)

				runlen = 0;

			runlen++;

			fp = rabin_slide(fp, ch);

		}



		/* See if there is a word-aligned window-sized run of equal characters */

		if (runlen >= RABIN_WINDOW_SIZE + sizeof(unsigned) - 1) {

			/* Skip ahead to end of run of identical input characters */

			while (j + k < len && data[j + k] == ch) {

				k++;

				runlen++;

			}



			/* Although matches are usually anchored at the end, in the case

			   of extended runs of equal characters it is better to anchor after the

			   first RABIN_WINDOW_SIZE bytes. This allows for quick skip ahead 

			   while matching such runs, avoiding unneeded fingerprint calculations.

			   Also, when anchoring at the end, matches will be generated after

			   every word, because the fingerprint stays constant. Even though

			   all matches would get combined during match optimization, 

			   it wastes time and space. */

			if (runlen > maxlen[pch] + 4) {

				unsigned ofs;

				/* ofs points RABIN_WINDOW_SIZE bytes after the start of the run,

				   rounded up to the next word */

				ofs = j + k - runlen + RABIN_WINDOW_SIZE + (sizeof (unsigned) - 1);

				ofs -= ofs % sizeof(unsigned);

				maxofs[pch] = ofs;

				maxlen [pch] = runlen;

				assert(maxfp[pch] == 0 || maxfp[pch] == (unsigned)fp);

				maxfp[pch] = (unsigned)fp;

			}

			/* Keep input aligned as if no special run processing had taken place */

			j += k - (k % index_step) - index_step;

			k = index_step;

		}



		/* Testing showed that avoiding collisions using secondary hashing, or

		   hash chaining had little effect and is not worth the time. */

		hash = ((unsigned)fp) & (idx_size - 1);

		idx[hash] = j + k;

	}



	/* Lastly, index the longest runs of equal characters found before.

	   This ensures we always match the longerst such runs available.  */

	for (j = 0; j < 256; j++) 

		if (maxlen[j]) 

			idx[maxfp[j] % idx_size] = maxofs[j];

}



/* Match data against the current index and record all possible copies */

static int find_copies(unsigned char *data, size_t len)

{

	size_t j = 0;

	u_int64_t fp = 0;



	rabin_reset();



	while (j < RABIN_WINDOW_SIZE && j < len)

		fp = rabin_slide(fp, data[j++]);



	while (j < len) { 

		unsigned hash, ofs, src, tgt, runlen, maxrun;



		fp = rabin_slide(fp, data[j++]);

		hash = fp & (idx_size - 1);

		ofs = idx[hash];



		/* Invariant:

		   data[0] .. data[j-1] has been processed

		   fp is fingerprint of sliding window ending at j-1

		   ofs is zero or points just past tentative match

		   ofs is a multiple of index_step */



		if (!ofs)

			continue;



		runlen = 0;

		tgt = j - 4;

		src = ofs - 4;

		maxrun = MIN(idx_data_len - src, len - tgt);



		/* Hot loop */

		while (runlen < maxrun &&

		       data[tgt + runlen] == idx_data[src + runlen])

			runlen++;

		if (runlen < 4)

			continue;



		if (copy_count == max_copies) {

			max_copies *= 2;

			if (!copies) {

				max_copies = MAX_COPIES;

				copies = malloc(max_copies * sizeof(CopyInfo));

			} else {

				copies = realloc(copies, max_copies * sizeof (CopyInfo));

			}

			if (!copies)

				return 0;

		}



		copies[copy_count].src = src;

		copies[copy_count].tgt = tgt;

		copies[copy_count].length = runlen;

		copy_count++;



		/* For runs extending more than RABIN_WINDOW_SIZE bytes beyond j,

		   skip ahead to prevent useless fingerprint computations. */

		if (tgt + runlen > j + RABIN_WINDOW_SIZE)

			j = tgt + runlen - RABIN_WINDOW_SIZE;



		/* Quickly scan ahead without looking for matches

		   until the end of this run */

		while (j < tgt + runlen)

			fp = rabin_slide(fp, data[j++]);

	}



	return 1;

}



static unsigned header_length(unsigned srclen, unsigned tgtlen)

{

	unsigned len = 0;

	assert (srclen <= MAX_SIZE && tgtlen <= MAX_SIZE);



	/* GIT headers start with the length of the source and target,

	   with 7 bits per byte, least significant byte first, and

	   the high bit indicating continuation. */

	do { len++; srclen >>= 7; } while (srclen);

	do { len++; tgtlen >>= 7; } while (tgtlen);



	return len;

}



static unsigned char *write_header(unsigned char *patch, unsigned srclen, unsigned tgtlen)

{

	assert (srclen <= MAX_SIZE && tgtlen <= MAX_SIZE);



	while (srclen >= 0x80) {

		*patch++ = srclen | 0x80;

		srclen >>= 7;

	}

	*patch++ = srclen;



	while (tgtlen >= 0x80) {

		*patch++ = tgtlen | 0x80;

		tgtlen >>= 7;

	}

	*patch++ = tgtlen;



	return patch;

}



static unsigned data_length(unsigned length)

{

	/* Can only include 0x7f data bytes per command */

	unsigned partial = length % 0x7f;

	assert (length > 0 && length <= MAX_SIZE);

	if (partial) partial++;

	return partial + (length / 0x7f) * 0x80;

}



static unsigned char *write_data(unsigned char *patch, unsigned char *data, unsigned size)

{

	assert (size > 0 && size < MAX_SIZE);

	/* The return value must be equal to patch + data_length (patch, size).

	   This correspondence is essential for calculating the patch size.  */



	/* GIT has no data commands for large data, rest is same as GDIFF */

	do {

		unsigned s = size;

		if (s > 0x7f)

			s = 0x7f;

		*patch++ = s;

		memcpy(patch, data, s);

		data += s;

		patch += s;

		size -= s;

	} while (size);



	return patch;

} 



static unsigned copy_length (unsigned offset, unsigned length)

{

	unsigned size = 0;



	assert (offset < MAX_SIZE && length < MAX_SIZE);



	/* For now we only copy a maximum of 0x10000 bytes per command.

	   Longer copies are broken into pieces of that size. */

	do {

		signed s = length;

		if (s > 0x10000)

			s = 0x10000;

		size += !!(s & 0xff) + !!(s & 0xff00);

		size += !!(offset & 0xff) + !!(offset & 0xff00) + 

			!!(offset & 0xff0000) + !!(offset & 0xff000000);

		size += 1;

		offset += s;

		length -= s;

	} while (length);



	return size;

}



static unsigned char * write_copy(unsigned char *patch, unsigned offset, unsigned size)

{

	/* The return value must be equal to patch + copy_length (patch,offset,size).

	   This correspondence is essential for calculating the patch size.  */



	do {

		unsigned char c = 0x80, *cmd = patch++;

		unsigned v, s = size;

		if (s > 0x10000)

			s = 0x10000;



		v = offset;

		if (v & 0xff) c |= 0x01, *patch++ = v;

		v >>= 8;

		if (v & 0xff) c |= 0x02, *patch++ = v;

		v >>= 8;

		if (v & 0xff) c |= 0x04, *patch++ = v;

		v >>= 8;

		if (v & 0xff) c |= 0x08, *patch++ = v;



		v = s;

		if (v & 0xff) c |= 0x10, *patch++ = v;

		v >>= 8;

		if (v & 0xff) c |= 0x20, *patch++ = v;



		*cmd = c;

		offset += s;

		size -= s;

	} while (size);



	return patch;

} 



static unsigned process_copies (unsigned char *data, unsigned length, unsigned maxlen)

{

	int j;

	unsigned ptr = length;

	unsigned patch_bytes = header_length(idx_data_len, length);



	/* Work through the copies backwards, extending each one backwards. */

	for (j = copy_count - 1; j >= 0; j--) {

		CopyInfo *copy = copies+j;

		unsigned src = copy->src;

		unsigned tgt = copy->tgt;

		unsigned len = copy->length;

		int data_follows;



		if (tgt + len > ptr) {

			/* Part of copy already covered by later one, so shorten copy. */

			if (ptr < tgt) {

				/* Copy completely disappeared, but guess that a backward extension

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



		while (src && tgt && idx_data[src - 1] == data[tgt - 1]) {

			src--;

			tgt--;

		}

		len += copy->tgt - tgt;



		data_follows = (tgt + len < ptr);



		/* A short copy may cost as much as 6 bytes for the copy and

		   5 as result of an extra data command.

		   It's not worth having extra copies in order to just save a byte or two.

		   Being too smart here may hurt later compression as well. */

		if (len < (data_follows ? 16 : 10))

			len = 0;



		/* Some target data is not covered by the copies, account for

		   the DATA command that will follow the copy. */

		if (len && data_follows) 

			patch_bytes += data_length(ptr - (tgt + len));



		/* Everything about the copy is known and will not change.

		   Write back the new information and update the patch size

		   with the size of the copy instruction. */

		copy->length = len;

		copy->src = src;

		copy->tgt = tgt;



		if (len) {

			/* update patch size for copy command */

			patch_bytes += copy_length (src, len);

			ptr = tgt;

		} else if (j == copy_count - 1) {

			/* Remove empty copies at end of list. */

			copy_count--;

		}



		if (patch_bytes > maxlen)

			return 0;

	}



	/* Account for data before first copy */

	if (ptr != 0)

		patch_bytes += data_length(ptr);



	if (patch_bytes > maxlen)

		return 0;

	return patch_bytes;

}



static unsigned calculate_delta(void *to_buf, unsigned long to_size, unsigned long max_size)

{

	assert (to_size < MAX_SIZE);



	if (!find_copies(to_buf, to_size))

		return 0;

	return process_copies(to_buf, to_size, max_size);

}



static void *create_delta (unsigned char *data, unsigned len, unsigned delta_size)

{

	unsigned char *delta = malloc(delta_size);

	unsigned char *ptr = delta;

	unsigned offset = 0;

	int j;



	ptr = write_header(ptr, idx_data_len, len);



	for (j = 0; j < copy_count; j++) {

		CopyInfo *copy = copies + j;

		unsigned copylen = copy->length;



		if (!copylen)

			continue;



		if (copy->tgt > offset) {

			assert (delta_size - (ptr - delta) > data_length(copy->tgt - offset));

			ptr = write_data(ptr, data + offset, copy->tgt - offset);

		}



		assert(delta_size - (ptr - delta) >= copy_length(copy->src, copylen));

		ptr = write_copy(ptr, copy->src, copylen);

		offset = copy->tgt + copylen;

	}



	if (offset < len)

		ptr = write_data(ptr, data + offset, len - offset);



	assert(ptr - delta == delta_size);



	return delta;

}



static void finalize_idx()

{

	free(copies);

	copies = 0;

	max_copies = 0;

	copy_count = 0;

	free(idx);

	idx = 0;

	idx_size = 0;

	idx_data = 0;

	idx_data_len = 0;

}



void *diff_delta(void *from_buf, unsigned long from_size,

		 void *to_buf, unsigned long to_size,

		 unsigned long *delta_size, unsigned long max_size)

{

	unsigned char *delta = 0;

	unsigned dsize;



	assert (from_size <= MAX_SIZE && to_size <= MAX_SIZE);

	init_idx(from_buf, from_size, 1); /* Use optimization level 1 */

	if (!max_size)

		max_size = MAX_SIZE;

	dsize = calculate_delta (to_buf, to_size, max_size);

	if (dsize)

		delta = create_delta (to_buf, to_size, dsize);

	finalize_idx ();

	if (delta)	

		*delta_size = dsize;

	return delta;

}


--Boundary_(ID_5MH4IoU+bG7DXQp2bcVLsw)--
