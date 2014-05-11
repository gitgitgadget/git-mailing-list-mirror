From: "Storm-Olsen, Marius" <Marius.Storm-Olsen@student.bi.no>
Subject: Re: optimising a push by fetching objects from nearby repos
Date: Sun, 11 May 2014 03:11:57 +0000
Message-ID: <1399777917522.41294@student.bi.no>
References: <536E2C19.3000202@gmail.com>
 <xmqqtx8xuz3b.fsf@gitster.dls.corp.google.com> <536ECC93.1070102@gmail.com>
 <1399772049733.13154@student.bi.no> <536EDC1C.5040101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	milki <milki@rescomp.berkeley.edu>
To: Sitaram Chamarty <sitaramc@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 11 05:12:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjKBN-0007ix-RM
	for gcvg-git-2@plane.gmane.org; Sun, 11 May 2014 05:12:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757761AbaEKDMF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2014 23:12:05 -0400
Received: from mail-db3lp0082.outbound.protection.outlook.com ([213.199.154.82]:28276
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757660AbaEKDMD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 May 2014 23:12:03 -0400
Received: from DBXPR07MB110.eurprd07.prod.outlook.com (10.242.138.148) by
 DBXPR07MB109.eurprd07.prod.outlook.com (10.242.138.147) with Microsoft SMTP
 Server (TLS) id 15.0.939.12; Sun, 11 May 2014 03:11:58 +0000
Received: from DBXPR07MB110.eurprd07.prod.outlook.com ([169.254.6.161]) by
 DBXPR07MB110.eurprd07.prod.outlook.com ([169.254.6.161]) with mapi id
 15.00.0939.000; Sun, 11 May 2014 03:11:58 +0000
Thread-Topic: optimising a push by fetching objects from nearby repos
Thread-Index: AQHPbFVRF04hHlEsxka8y+FpDjZfZZs6TapygABDioD//7Q3AIAAXk4A//+9IgA=
In-Reply-To: <536EDC1C.5040101@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: DBXPR07MB110.eurprd07.prod.outlook.com
 (15.00.0939.000)
x-originating-ip: [2601:e:a80:455:b9a8:d0db:3cae:ae12]
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009001)(6009001)(428001)(479174003)(377454003)(24454002)(51704005)(199002)(189002)(36756003)(83322001)(20776003)(64706001)(46102001)(76482001)(15202345003)(92726001)(19580395003)(77982001)(80022001)(81542001)(86362001)(76176999)(83072002)(4396001)(74662001)(85852003)(87936001)(81342001)(99396002)(101416001)(31966008)(74502001)(74482001)(21056001)(79102001)(92566001)(2656002)(54356999)(50986999)(3826001);DIR:OUT;SFP:1101;SCL:1;SRVR:DBXPR07MB109;H:DBXPR07MB110.eurprd07.prod.outlook.com;FPR:;MLV:sfv;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
received-spf: None (: student.bi.no does not designate permitted sender
 hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Marius.Storm-Olsen@student.bi.no; 
Content-ID: <F52B5E1A112E0A4D9F4DE3A2AFE52DE9@nbsstd.onmicrosoft.com>
X-OriginatorOrg: student.bi.no
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248671>

On 5/10/2014 9:10 PM, Sitaram Chamarty wrote:
> On 05/11/2014 07:04 AM, Storm-Olsen, Marius wrote:
>> On 5/10/2014 8:04 PM, Sitaram Chamarty wrote: Many of the Git repo
>> managers will neatly set up a server-side repo clone for you, with
>> alternates into the original repo saving both network and disk
>> I/O.
>
> Gitolite already has a "fork" command that does that (though it uses
> "-l", not alternates).  I specifically don't want to use alternates,
> and I also specifically am looking for something that activates on a
> push -- in the situations I am looking to optimise, the clone already
> happened.

You can probably get the managers to do a fork without alternates too.

Also, it doesn't matter if you have already cloned from the original 
repo remotely. If you use the git manager to clone the original repo on 
the server, and you push to your new repo, only your changes will go 
back over the wire. The git protocol will figure out only which objects 
are missing to complete the new HEAD, and send those.

So
    1. Clone remote repo
    2. Hack hack hack
    3. Fork repo on server
    4. Push changes to your own remote repo
is equally efficient.


>> So your work flow would instead be:
>>     1. Fork repo on server
>>     2. Remotely clone your own forked repo
>>
>> I think it's more appropriate to handle this higher level operation
>> within the security context of a git repo manager, rather than directly
>> in git.
>
> Yes, because of the "read access" check in my suggested procedure to
> handle this.  (Otherwise this is as valid as the plan suggested for
> clone in Junior's email in [1]).

It's similar, but security issues come into play due to the swapped 
direction, which is why I think it's wrong to place it in the push 
command. Now, having the 'borrow' complement to 'reference' in Git seems 
like a good idea, and should work for your case too, but IMO should be 
configured with in the security context of the repo manager, and not on 
an individual push. *shrug*


> [1]:
> http://thread.gmane.org/gmane.comp.version-control.git/243918/focus=245397
>
> I will certainly be doing this in gitolite.  The point of my post was to
> validate the flow with the *git* experts in case they catch something I
> missed, not to say "this should be done *in* git".

Absolutely, and I think that's how everyone perceived it :) It's a good 
idea, with some tweaks, I think.


-- 
.marius
