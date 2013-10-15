From: pro-logic <pro-logic@optusnet.com.au>
Subject: Re: Windows performance / threading file access
Date: Tue, 15 Oct 2013 15:22:02 -0700 (PDT)
Message-ID: <3bb056f6-5f8b-486e-8e5e-9bf541bd0d0b@googlegroups.com>
References: <CAHOQ7J_ZZ=7j-5ULd7Tdvbiqg4inhwi+fue_w6WAtNRkvZSwsg@mail.gmail.com>
 <52570BC1.2040208@gmail.com>
 <52574B90.3070309@gmail.com>
 <CAHOQ7J_sNnajm9M+QUd-QwkQGP2vOidzAW5_5EzsdwBGTDCnSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_1574_5245668.1381875722572"
Cc: Karsten Blees <karsten.blees@gmail.com>, 
	Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org, 
	szager@google.com
To: msysgit@googlegroups.com
X-From: msysgit+bncBCNJBMNCRQBBBDEA66JAKGQEITJCT5Y@googlegroups.com Wed Oct 16 00:22:07 2013
Return-path: <msysgit+bncBCNJBMNCRQBBBDEA66JAKGQEITJCT5Y@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-oa0-f58.google.com ([209.85.219.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCNJBMNCRQBBBDEA66JAKGQEITJCT5Y@googlegroups.com>)
	id 1VWD0A-0004sa-CS
	for gcvm-msysgit@m.gmane.org; Wed, 16 Oct 2013 00:22:06 +0200
Received: by mail-oa0-f58.google.com with SMTP id l20sf1656827oag.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 15 Oct 2013 15:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:x-original-sender:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=hYJlhaODEciEvguc68l0lP0Z9oCNqp2Gpv7bW2uYVU0=;
        b=kZ3qh9Cuw4BQB4Ju2wkQAB9tTi+k9SqsMIYPMIWyl+nfjQcc7aijFUpMll3jXBJKVR
         K80taGIhb6ytqwRgrxupn3YGkvfxdh+DkQMn4UdSSfksAzzIC6fxJoFrU7Yh9/f7Cnlt
         4FN6gz9jvH+ewEGAdqx/V4N+ohdW1ZM6rghNCK3u8jPkdpgtEydRjGhOM3DwrFG3PNav
         amCtDXMy/FfWTDFKW0/gYdV/HXfxXdtSwawEqw+BYE2SXcGyuFFzDCleF4wtI2YS9QnB
         oJbHN/QzhVy2hWAB1DkT786OneD46ScRa24hVXf4ppk8WkECa6ytLhjB8xjOaKc4J/Eg
         DNzg==
X-Received: by 10.50.73.39 with SMTP id i7mr551241igv.1.1381875725366;
        Tue, 15 Oct 2013 15:22:05 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.103.1 with SMTP id fs1ls2846459igb.23.canary; Tue, 15 Oct
 2013 15:22:04 -0700 (PDT)
X-Received: by 10.50.9.33 with SMTP id w1mr545014iga.12.1381875724375;
        Tue, 15 Oct 2013 15:22:04 -0700 (PDT)
In-Reply-To: <CAHOQ7J_sNnajm9M+QUd-QwkQGP2vOidzAW5_5EzsdwBGTDCnSA@mail.gmail.com>
X-Original-Sender: pro-logic@optusnet.com.au
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236206>

------=_Part_1574_5245668.1381875722572
Content-Type: text/plain; charset=ISO-8859-1

I also get fairly slow performance out of the checkout / reset operations 
on windows. 

This discussion got me trying to work out what's taking so long on windows. 
To help I used killcache [1] to flush the HDD cache and Very Sleepy [2] to 
profile the code. I couldn't use the GIT_TRACE_PERFORMANCE [3] patch as 
that seems to only work on script commands, and in my case I just get a 
result of "335 seconds git reset --hard head" from the log. 

After running killcache I ran very sleepy connected to git, and according 
to the profile:
95.5% of the time is spent in do_lstat (mingw.c) / NtQueryFullAttributeFile 
(ntdll) 

For fun, not knowing if I would break anything or not (it probably does), I 
wrapped the entire unpack_trees method in the fscache [4] and the total git 
reset --hard head time fell from 335 seconds to 28 seconds, a 11x 
improvement. 

Albert
[1] https://github.com/sgraham/killcache
[2] http://www.codersnotes.com/sleepy
[3] https://github.com/msysgit/git/pull/38
[4] https://github.com/msysgit/git/pull/94

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.

------=_Part_1574_5245668.1381875722572
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I also get fairly slow performance out of the checkout / r=
eset operations on windows.&nbsp;<div><br></div><div>This discussion got me=
 trying to work out what's taking so long on windows. To help I used killca=
che [1] to flush the HDD cache and Very Sleepy [2] to profile the code. I c=
ouldn't use the&nbsp;GIT_TRACE_PERFORMANCE [3] patch as that seems to only =
work on script commands, and in my case I just get a result of "335 seconds=
 git reset --hard head" from the log.&nbsp;</div><div><br></div><div>After =
running killcache I ran very sleepy connected to git, and according to the =
profile:</div><div>95.5% of the time is spent in do_lstat (mingw.c) / NtQue=
ryFullAttributeFile (ntdll)&nbsp;</div><div><br></div><div>For fun, not kno=
wing if I would break anything or not (it probably does), I wrapped the ent=
ire unpack_trees method in the fscache [4] and the total git reset --hard h=
ead time fell from 335 seconds to 28 seconds, a 11x improvement.&nbsp;</div=
><div><br></div><div>Albert</div><div>[1]&nbsp;https://github.com/sgraham/k=
illcache</div><div>[2]&nbsp;http://www.codersnotes.com/sleepy</div><div>[3]=
&nbsp;https://github.com/msysgit/git/pull/38</div><div>[4]&nbsp;https://git=
hub.com/msysgit/git/pull/94</div><div><br></div></div>

<p></p>

-- <br />
-- <br />
*** Please reply-to-all at all times ***<br />
*** (do not pretend to know who is subscribed and who is not) ***<br />
*** Please avoid top-posting. ***<br />
The msysGit Wiki is here: <a href=3D"https://github.com/msysgit/msysgit/wik=
i">https://github.com/msysgit/msysgit/wiki</a> - Github accounts are free.<=
br />
&nbsp;<br />
You received this message because you are subscribed to the Google<br />
Groups &quot;msysGit&quot; group.<br />
To post to this group, send email to msysgit@googlegroups.com<br />
To unsubscribe from this group, send email to<br />
msysgit+unsubscribe@googlegroups.com<br />
For more options, and view previous threads, visit this group at<br />
<a href=3D"http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den">http:=
//groups.google.com/group/msysgit?hl=3Den_US?hl=3Den</a><br />
&nbsp;<br />
--- <br />
You received this message because you are subscribed to the Google Groups &=
quot;msysGit&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.<br />
For more options, visit <a href=3D"https://groups.google.com/groups/opt_out=
">https://groups.google.com/groups/opt_out</a>.<br />

------=_Part_1574_5245668.1381875722572--
