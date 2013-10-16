From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] t3600: fix broken "choking git rm" test
Date: Tue, 15 Oct 2013 17:18:04 -0700
Message-ID: <20131016001804.GJ9464@google.com>
References: <1381881687-11179-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Oct 16 02:18:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWEoY-0005Zp-4t
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 02:18:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933729Ab3JPASJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Oct 2013 20:18:09 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:48080 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759708Ab3JPASH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Oct 2013 20:18:07 -0400
Received: by mail-pd0-f171.google.com with SMTP id z10so18331pdj.16
        for <git@vger.kernel.org>; Tue, 15 Oct 2013 17:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=NEVThLPPR4UDN3Ma6O2ooE63CgZwhXmM1vK3vh+gYTM=;
        b=bLiO3p48hjLaUwFt9WiFXr5vp0BuNIJCz4AY9FhMKEyYP3fDA3gfMWRR6JMylesmdv
         ELrWHqJDUnxIYvS5khbLBgt6I+zuSv4MtNxWJPw0Mh9vl7gMQx9GqEdjhzuW8/ABgsre
         dNXwDp+ZoPN2MqVlbLo6Mntg2pF1c3vFdCZj9wSom2G+5uiOazapv5oaLvRc57t9nsFk
         GEvBDJUulCjP0GaC30VDQNpn4vkzPRmiWqjgJ6TesSqz3wezwL/xyEeu/gPxq/4unvSD
         VwM5icgnfGM/BC+W7S3VSP1v1oorxrQUc/6+upqKFuc7CByzHb8/mMMKaF7OFYd4xRtZ
         rxNA==
X-Received: by 10.68.216.35 with SMTP id on3mr44659376pbc.86.1381882687120;
        Tue, 15 Oct 2013 17:18:07 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id be1sm21629681pbb.28.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 15 Oct 2013 17:18:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1381881687-11179-1-git-send-email-szeder@ira.uka.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236225>

SZEDER G=E1bor wrote:

> The test 'choking "git rm" should not let it die with cruft' is
> supposed to check 'git rm's behavior when interrupted by provoking a
> SIGPIPE while 'git rm' is busily deleting files from a specially
> crafted index.
>
> This test is silently broken for the following reasons:
[...]
> Signed-off-by: SZEDER G=E1bor <szeder@ira.uka.de>
> ---
> A particularly funny one from the fallout of gmane/236183

=46un. :)  Makes sense.

> --- a/t/t3600-rm.sh
> +++ b/t/t3600-rm.sh
> @@ -240,18 +240,15 @@ test_expect_success 'refresh index before check=
ing if it is up-to-date' '
> =20
>  test_expect_success 'choking "git rm" should not let it die with cru=
ft' '
>  	git reset -q --hard &&
> +	test_when_finished "rm -f .git/index.lock ; git reset -q --hard" &&

I'd use "&&" here --- the test_cleanup checks the exit status from
this scriptlet, so it's a good habit.

[...]
> -	test -f .git/index.lock
> -	status=3D$?
> -	rm -f .git/index.lock
> -	git reset -q --hard
> -	test "$status" !=3D 0
> +	test ! -f .git/index.lock

Gah.  Thanks for cleaning it up.

Maybe test_path_is_missing would make sense here?  (It would notice a
=2Egit/index.lock directory, which is not very likely :), but more
importantly, it says why it is failing the test when it fails.)

With or without the changes mentioned above,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.

diff --git i/t/t3600-rm.sh w/t/t3600-rm.sh
index 8386b54..540c49b 100755
--- i/t/t3600-rm.sh
+++ w/t/t3600-rm.sh
@@ -240,7 +240,7 @@ test_expect_success 'refresh index before checking =
if it is up-to-date' '
=20
 test_expect_success 'choking "git rm" should not let it die with cruft=
' '
 	git reset -q --hard &&
-	test_when_finished "rm -f .git/index.lock ; git reset -q --hard" &&
+	test_when_finished "rm -f .git/index.lock && git reset -q --hard" &&
 	i=3D0 &&
 	while test $i -lt 12000
 	do
@@ -248,7 +248,7 @@ test_expect_success 'choking "git rm" should not le=
t it die with cruft' '
 	    i=3D$(( $i + 1 ))
 	done | git update-index --index-info &&
 	git rm -n "some-file-*" | : &&
-	test ! -f .git/index.lock
+	test_path_is_missing .git/index.lock
 '
=20
 test_expect_success 'rm removes subdirectories recursively' '
