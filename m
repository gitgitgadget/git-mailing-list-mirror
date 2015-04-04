From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: git 2.3.4, ssh: Could not resolve hostname
Date: Sat, 04 Apr 2015 09:21:44 +0200
Message-ID: <551F9108.6090301@web.de>
References: <56B33978-76A0-4EE0-BCC0-EF030FD52E41@rawsound.com> <20150402180914.GA19081@peff.net> <201C57EF-FC96-4FFB-81D2-90F94428A6CA@rawsound.com> <20150402191452.GA20420@peff.net> <xmqq7ftujpu1.fsf@gitster.dls.corp.google.com> <62968860-FA58-4339-AF0B-264197EC8A04@rawsound.com> <20150402193524.GA21555@peff.net> <551DD887.2010403@web.de> <51689E6C-93FD-4E77-8FF3-BB8EC7EA735A@gmail.com> <701694C7-311A-4625-A871-48D5F04EB0F9@rawsound.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org list" <git@vger.kernel.org>
To: "Reid Woodbury Jr." <reidw@rawsound.com>,
	"Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 04 09:22:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YeIPD-000352-PM
	for gcvg-git-2@plane.gmane.org; Sat, 04 Apr 2015 09:22:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752026AbbDDHWE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Apr 2015 03:22:04 -0400
Received: from mout.web.de ([212.227.15.14]:62150 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751894AbbDDHWB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2015 03:22:01 -0400
Received: from macce.local ([93.222.5.85]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0Lxwjk-1ZYLVe2Uy4-015KEz; Sat, 04 Apr 2015 09:21:47
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <701694C7-311A-4625-A871-48D5F04EB0F9@rawsound.com>
X-Provags-ID: V03:K0:GCBxom+/ITuUB8h+CukTookizZXxq+ryZT1JRfepcLyKZ66k+oa
 TOF1TcGM1J4/P8NN8aybY+Y4uoyBFyLc0hYkSJiUWI2CwXGyi2X2EY73AYkVxOV9dtwvxA7
 MFlDsOk4SSVciZLlOWKtkaJwKKFS9xPvha7+gSiPyU4fENRcYfnwYufiSqhYRb0OZFP0+pl
 kAisYCQqunRnaGLurBb2Q==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266767>

On 2015-04-04 02.19, Reid Woodbury Jr. wrote:
> Thanks for keeping me in the loop!
>=20
> I have two thoughts on handling input:
>=20
> As a coder I want to know exactly what's going on in my code. If I've=
 given erroneous input I'd like to know about it in the most useful and=
 quickest way, never glossed over, liberally accepted, nor fixed for me=
 even if the input is non-ambigous. I won't learn the right way unless =
I'm told. I enjoy that when I've typo'd a command in GIT it gives usefu=
l suggestions to what I might have meant.
>=20
> But, most of the coding *I* do is for the non-coder or the general en=
d user. These might be people that would reasonably yell at their compu=
ter screen "you know what I meant!" So I try to be more liberal in the =
input I write code to accept by filtering it, cleaning it, etc. I'll ev=
en filter input by keystroke when possible. I have the philosophy: don'=
t tell the user that they input something bad, just prevent them from i=
nputting it to begin with. I know, this is appropriate when building a =
GUI and not for CLI.
>=20
> thanks for listening
> Reid Woodbury
>=20
Thanks for the report.
(And please try to avoid top-posting to this list in the future ;-)

The basic fix will look like below, but I need to update the test-suite=
 as well.


diff --git a/connect.c b/connect.c
index ce0e121..c8744f3 100644
--- a/connect.c
+++ b/connect.c
@@ -310,6 +310,8 @@ static void get_host_and_port(char **host, const ch=
ar **port)
                if (end !=3D colon + 1 && *end =3D=3D '\0' && 0 <=3D po=
rtnr && portnr < 65536) {
                        *colon =3D 0;
                        *port =3D colon + 1;
+               } else if (!colon[1]) {
+                       *colon =3D 0;
                }
        }
 }
@@ -385,7 +387,7 @@ static int git_tcp_connect_sock(char *host, int fla=
gs)
        freeaddrinfo(ai0);
=20
        if (sockfd < 0)
-               die("unable to connect to %s:\n%s", host, error_message=
=2Ebuf);
+               die("unable to connect to '%s' :\n%s", host, error_mess=
age.buf);
=20
        enable_keepalive(sockfd);

>=20
>> On Apr 3, 2015, at 2:32 PM, Kyle J. McKay <mackyle@gmail.com> wrote:
>>
>> On Apr 2, 2015, at 17:02, Torsten B=F6gershausen wrote:
>>
>>> On 2015-04-02 21.35, Jeff King wrote:
>>>> On Thu, Apr 02, 2015 at 12:31:14PM -0700, Reid Woodbury Jr. wrote:
>>>>
>>>>> Ah, understand. Here's my project URL for 'remote "origin"' with =
a
>>>>> more meaningful representation of their internal FQDN:
>>>>>
>>>>> 	url =3D ssh://rwoodbury@systemname.groupname.online:/opt/git/inv=
entory.git
>>>>>
>>>>> The "online" is their literal internal TLD.
>>>>
>>>> Thanks. The problem is the extra ":" after "online"; your URL is
>>>> malformed. You can just drop that colon entirely.
>>>>
>>>> I do not think we need to support this syntax going forward (the c=
olon
>>>> is meaningless here, and our documentation is clear that it should=
 go
>>>> with a port number), but on the other hand, it might be nice to be=
 more
>>>> liberal, as we were in v2.3.3 and prior. I'll leave it to Torsten =
to see
>>>> whether supporting that would hurt some of the other cases, or whe=
ther
>>>> it would make the code too awkward.
>>>>
>>>> -Peff
>>>
>>> Thanks for digging.
>>>
>>> This makes my think that it is
>>> a) non-standard to have the extra colon
>>
>> It's not.  See RFC 3986 appendix A:
>>
>>  authority =3D [ userinfo "@" ] host [ ":" port ]
>>
>>  port =3D *DIGIT
>>
>> "*DIGIT" means (see RFC 2234 section 3.6) zero or more digits.
>>
>>> b) The error message could be better
>>> c) We don't have a test case
>>> d) This reminds my of an improvement from Linus:
>>> 608d48b2207a61528
>>> ......
>>>   So when somebody passes me a "please pull" request pointing to so=
mething
>>>   like the following
>>>
>>>   	git://git.kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.g=
it
>>>
>>>   (note the extraneous colon at the end of the host name), git woul=
d happily
>>>   try to connect to port 0, which would generally just cause the re=
mote to
>>>   not even answer, and the "connect()" will take a long time to tim=
e out.
>>> .....
>>>
>>> Sorry guys for the regression, the old parser handled the extra col=
on as "port 0",
>>> the new one looks for the "/" as the end of the hostname (and the b=
eginning of the path)
>>>
>>> Either we accept the extra colon as before, or the parser puts out =
a better error message,
>>
>> [...]
>>
>>> Spontaneously I would say that a trailing ':' at the end of a hostn=
ame in the ssh:// scheme
>>> can be safely ignored, what do you think ?
>>
>> You know, there is a "url_normalize" routine in urlmatch.h/urlmatch.=
c that checks for a lot of these things and provides a translated error=
 message if there's a problem as well as normalizing and separating out=
 the various parts of the URL.  It does not currently handle default po=
rts for anything other than http[s] but it would be simple enough to ad=
d support for ssh, git, ftp[s] and rsync default ports too.
>>
>> -Kyle
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
