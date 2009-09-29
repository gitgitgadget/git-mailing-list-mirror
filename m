From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: clone from url with email address as username?(escaping @ symbol)
Date: Tue, 29 Sep 2009 20:03:25 +0200
Message-ID: <vpq1vlpr5le.fsf@bauges.imag.fr>
References: <970bc7c80909290720i1c5566fer1c1a3db744edc609@mail.gmail.com>
	<fabb9a1e0909290725w616c3ea9vcb1d2c53950f7788@mail.gmail.com>
	<vpq1vlp962h.fsf@bauges.imag.fr>
	<fabb9a1e0909290732h5119170ew133d906b67e49f99@mail.gmail.com>
	<970bc7c80909290831l59b7fc4at4ec0082f42f3ef87@mail.gmail.com>
	<vpq63b1u1p6.fsf@bauges.imag.fr>
	<970bc7c80909291051q5dff9209u650cee4f84d92fae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Ben Bennett <benbennett@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 29 20:06:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Msh5b-00030J-PF
	for gcvg-git-2@lo.gmane.org; Tue, 29 Sep 2009 20:06:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753046AbZI2SGF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Sep 2009 14:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753006AbZI2SGF
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Sep 2009 14:06:05 -0400
Received: from imag.imag.fr ([129.88.30.1]:38624 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752997AbZI2SGE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2009 14:06:04 -0400
Received: from archeboc.imag.fr (archeboc.imag.fr [129.88.43.1])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n8TI3Pim005414
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 29 Sep 2009 20:03:25 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by archeboc.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Msh2r-0004Yd-CH; Tue, 29 Sep 2009 20:03:25 +0200
In-Reply-To: <970bc7c80909291051q5dff9209u650cee4f84d92fae@mail.gmail.com> (Ben Bennett's message of "Tue\, 29 Sep 2009 12\:51\:41 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 29 Sep 2009 20:03:26 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129319>

Ben Bennett <benbennett@gmail.com> writes:

> Is it escaping the %40 when passed down? I am getting an error 401  ,
> and checking the server logs , it is passing the %40 to the server in
> the username.
> Running curl from command line , I can connect, but through git , the
> username is getting mangled or I have something screwed up.

OK, so it seems Git should be fixed to unescape this %40 somewhere,
most likely in http_auth_init in http.c, in addition to by fix below.
http://curl.haxx.se/libcurl/c/curl_easy_unescape.html might help. I've
consumed by Git time budget for now, so if anyone else can have a
look ...

>> --- a/http.c
>> +++ b/http.c
>> @@ -281,9 +281,10 @@ static void http_auth_init(const char *url)
>> =A0 =A0 =A0 =A0 * "proto://<host>/..."?
>> =A0 =A0 =A0 =A0 */
>> =A0 =A0 =A0 =A0cp +=3D 3;
>> - =A0 =A0 =A0 at =3D strchr(cp, '@');
>> =A0 =A0 =A0 =A0colon =3D strchr(cp, ':');
>> =A0 =A0 =A0 =A0slash =3D strchrnul(cp, '/');
>> + =A0 =A0 =A0 for(at =3D slash-1; *at !=3D '@' && *at !=3D '/'; at--=
)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> =A0 =A0 =A0 =A0if (!at || slash <=3D at)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return; /* No credentials */
>> =A0 =A0 =A0 =A0if (!colon || at <=3D colon) {
>>

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
