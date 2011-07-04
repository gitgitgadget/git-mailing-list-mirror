From: Michele Marcionelli <michele.marcionelli@math.ethz.ch>
Subject: Re: push problem with anonymous access
Date: Mon, 4 Jul 2011 09:13:10 +0200
Message-ID: <FCA17A33-EC1F-4649-9047-D8D56BE11D46@math.ethz.ch>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 04 09:13:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QddLN-0003zT-Oj
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jul 2011 09:13:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037Ab1GDHNP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Jul 2011 03:13:15 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:57891 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752612Ab1GDHNP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jul 2011 03:13:15 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.289.1; Mon, 4 Jul
 2011 09:13:11 +0200
Received: from fibonacci.math.ethz.ch (129.132.147.190) by mail.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.289.1; Mon, 4 Jul
 2011 09:13:11 +0200
X-Mailer: Apple Mail (2.1084)
X-Originating-IP: [129.132.147.190]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176592>

Hi Ray

I tried as you suggested (even if to clone I don't need a password):

$ git clone https://michele:******@git.math.ethz.ch/git/math/public_tes=
t.git
=3D=3D>
Cloning into public_test...
remote: Counting objects: 15, done.
remote: Compressing objects: 100% (7/7), done.
remote: Total 15 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (15/15), done.

And in the apache logs:
129.132.147.190 - - [04/Jul/2011:08:14:40 +0200] "GET /git/math/public_=
test.git/info/refs?service=3Dgit-upload-pack HTTP/1.1" 200 264 "-" "git=
/1.7.5.4"
129.132.147.190 - - [04/Jul/2011:08:14:40 +0200] "POST /git/math/public=
_test.git/git-upload-pack HTTP/1.1" 200 1688 "-" "git/1.7.5.4"

But the when I push (and here is my problem):
$ cd public_test
$ echo foo >> TODO
$ git commit TODO -m bar
$ git push
=3D=3D>
error: Cannot access URL https://michele:******@git.math.ethz.ch/git/ma=
th/public_test.git/, return code 22
fatal: git-http-push failed

I get following in the apache logs:

=3D=3D> /var/log/httpd/git-ssl.access_log <=3D=3D
129.132.147.190 - - [04/Jul/2011:08:17:45 +0200] "GET /git/math/public_=
test.git/info/refs?service=3Dgit-receive-pack HTTP/1.1" 403 - "-" "git/=
1.7.5.4"
129.132.147.190 - - [04/Jul/2011:08:17:45 +0200] "GET /git/math/public_=
test.git/info/refs HTTP/1.1" 200 59 "-" "git/1.7.5.4"
=3D=3D> /var/log/httpd/git-ssl.error_log <=3D=3D
[Mon Jul 04 08:17:45 2011] [error] [client 129.132.147.190] Service not=
 enabled: 'receive-pack'
=3D=3D> /var/log/httpd/git-ssl.access_log <=3D=3D
129.132.147.190 - - [04/Jul/2011:08:17:45 +0200] "GET /git/math/public_=
test.git/HEAD HTTP/1.1" 200 23 "-" "git/1.7.5.4"
129.132.147.190 - - [04/Jul/2011:08:17:46 +0200] "PROPFIND /git/math/pu=
blic_test.git/ HTTP/1.1" 404 - "-" "git/1.7.5.4"
=3D=3D> /var/log/httpd/git-ssl.error_log <=3D=3D
[Mon Jul 04 08:17:46 2011] [error] [client 129.132.147.190] Request not=
 supported: '/var/www/vhosts/git/root/math/public_test.git/'


The problem that I see is that in the configuration (see also the "man =
git-http-backend") you have this

    <LocationMatch "^/git/.*/git-receive-pack$">

and "git push" do following request:

    /git/whatever/info/refs?service=3Dgit-receive-pack

which is not matched by the "LocationMarch".

Thx, Michele

PS: I'm not using WebDAV, since it is not documented in the man page.


On Jul 2, 2011, at 17:19 , Tay Ray Chuan wrote:

> On Sat, Jul 2, 2011 at 6:32 AM, Michele Marcionelli
> <michele.marcionelli <at> math.ethz.ch> wrote:
>> =3D=3D> /var/log/httpd/git-ssl.access_log <=3D=3D
>> 85.1.201.213 - - [02/Jul/2011:00:13:32 +0200] "GET
> /git/math/public_test.git/info/refs?service=3Dgit-receive-pack HTTP/1=
=2E1" 403 - "-" "git/1.7.5.4"
>=20
> Try
>=20
>  $ git clone https://<user>:<pwd>@git.math.ethz.ch/git/math/public_te=
st.git
>=20
> or put it in ~/.netrc.
>=20
> --=20
> Cheers,
> Ray Chuan

--
Michele Marcionelli =B7 mm@ethz.ch =B7 +41 44 632 6193
* Please consider the environment before printing
