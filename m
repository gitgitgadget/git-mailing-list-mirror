From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 03/12] git rm: display a warning for every unremovable
 file
Date: Sat, 27 Mar 2010 06:01:47 -0500
Message-ID: <20100327110147.GA1008@progeny.tock>
References: <1269617140-7827-1-git-send-email-peter@pcc.me.uk>
 <1269617140-7827-4-git-send-email-peter@pcc.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Peter Collingbourne <peter@pcc.me.uk>
X-From: git-owner@vger.kernel.org Sat Mar 27 12:01:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvTm0-0007BM-21
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 12:01:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752394Ab0C0LBb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Mar 2010 07:01:31 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:47654 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752258Ab0C0LBa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Mar 2010 07:01:30 -0400
Received: by ywh2 with SMTP id 2so4018807ywh.33
        for <git@vger.kernel.org>; Sat, 27 Mar 2010 04:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=C8QhxKTcwM8iVs41jUVO4/coFRKm2aHdVsJKhXbCSW8=;
        b=XU5zeNtcVyhPi5VNzZUEGQ3Y4iGIbpqfpXXcLkjJuBylDWMDJLQ1vws/8ueagGxyVJ
         0y2bmCeb2uxTHN90EXlt1UJmq6aD3oDdBP0Ad6/932yfdTX24YT1HjFHLWv7436fc3W/
         aaoyJYEmDiUL45mgNqj+TdTni32AZF+7kHfL4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=JIxV3BVr40/nc2pJelpWHIvzcFDHisCosdvirDmXs72mH8y6k9FvF2Rgj065QpC/P1
         zZcW2RAtrQQu9GbvjAXfn5K9QdWp9OCELc2THl26JrFjVZVXGLpQjl4DkqiZfj7AZOGN
         Zx+Xlucf8VEexQvZogLvHQDrhYl8SoKipzRRY=
Received: by 10.101.161.16 with SMTP id n16mr3553148ano.130.1269687688169;
        Sat, 27 Mar 2010 04:01:28 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm1720026iwn.4.2010.03.27.04.01.27
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 27 Mar 2010 04:01:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1269617140-7827-4-git-send-email-peter@pcc.me.uk>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143326>

Peter Collingbourne wrote:

> This patch causes git-rm to display a warning if it was unable to
> remove a file other than the first one, rather than silently ignoring
> the error, which was the previous behaviour.
>=20
> Signed-off-by: Peter Collingbourne <peter@pcc.me.uk>
[...]
> @@ -259,6 +259,8 @@ int cmd_rm(int argc, const char **argv, const cha=
r *prefix)
>  			}
>  			if (!removed)
>  				die_errno("git rm: '%s'", path);
> +			else
> +				warning("git rm: '%s': %s", path, strerror(errno));

My first reaction was to wonder what is going on.  Clearly someone
had been bothered by the obvious behavior of giving a long stream
of warnings or we wouldn=E2=80=99t have the current behavior.

But in fact, the unchanged code comment before the code you changed
and the message for commit d9b814cc (Add builtin "git rm" command,
2006-05-19) shows me wrong:

    So what happens is that if the _first_ file fails to be removed wit=
h "-f",=20
    we abort the whole "git rm". But once we've started removing, we do=
n't=20
    leave anything half done. If some of the other files don't exist, w=
e'll=20
    just ignore errors of removal from the working tree.

    This is only an issue with "-f", of course.

    I think the new behaviour is strictly an improvement, but perhaps m=
ore=20
    importantly, it is _different_. As a special case, the semantics ar=
e=20
    identical for the single-file case (which is the only one our test-=
suite=20
    seems to test).

I think the commit message could avoid this confusion.  Something like:

	When =E2=80=98git rm=E2=80=99 was built in (d9b814cc, 2006-05-19), its
	semantics changed: before, it just removed files until it
	encountered an error and then would error out, whereas since
	then, it makes an attempt to either remove all files or remove
	none at all.  In particular, if =E2=80=98git rm=E2=80=99 fails to remo=
ve a
	file after other files have already been removed, it does not
	abort but instead silently accepts the error.

	Better to warn the user in this case!

	This problem is particularly noticeable when dealing with
	submodules because ...

Some tests would be nice as well --- maybe something like the following=
?

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 0aaf0ad..a3861b8 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -126,6 +126,75 @@ test_expect_success 'Remove nonexistent file with =
--ignore-unmatch' '
 	git rm --ignore-unmatch nonexistent
 '
=20
+test_expect_success 'If the first (in alphabetical order) removal fail=
s, rm is cancelled' '
+	touch xyzzy &&
+	mkdir -p plugh &&
+	touch plugh/xyzzy &&
+	git add xyzzy plugh/xyzzy &&
+	git commit --allow-empty -a -m "two files to remove" &&
+	chmod a-w plugh &&
+	git ls-files --stage >before &&
+	test $(grep xyzzy before | wc -l) =3D 2 &&
+
+	test_must_fail git rm xyzzy plugh/xyzzy &&
+
+	test -e plugh/xyzzy &&
+	test -e xyzzy &&
+	git ls-files --stage >after &&
+	test_cmp before after
+'
+! test -e plugh || chmod 775 plugh
+rm -fr before after plugh xyzzy
+
+test_expect_success 'Best-effort behavior if the second removal fails'=
 '
+	touch plugh &&
+	mkdir -p xyzzy &&
+	touch xyzzy/plugh &&
+	git add plugh xyzzy/plugh &&
+	git commit --allow-empty -a -m "two files to remove" &&
+	chmod a-w xyzzy &&
+	: >expect &&
+
+	git rm plugh xyzzy/plugh &&
+
+	test -e xyzzy/plugh &&
+	! test -e plugh &&
+	git ls-files --stage plugh xyzzy/plugh >actual &&
+	test_cmp expect actual
+'
+! test -e xyzzy || chmod 775 xyzzy
+rm -fr expect actual plugh xyzzy
+
+test_expect_success 'Message when first removal fails' '
+	touch xyzzy &&
+	mkdir -p plugh &&
+	touch plugh/xyzzy &&
+	git add xyzzy plugh/xyzzy &&
+	git commit --allow-empty -a -m "two files to remove" &&
+	chmod a-w plugh &&
+
+	test_must_fail git rm xyzzy plugh/xyzzy 2>msg &&
+
+	grep "git rm: '\''plugh/xyzzy'\'':" msg
+'
+! test -e plugh || chmod 775 plugh
+rm -fr msg plugh xyzzy
+
+test_expect_success 'Message when second removal fails' '
+	touch plugh &&
+	mkdir -p xyzzy &&
+	touch xyzzy/plugh &&
+	git add plugh xyzzy/plugh &&
+	git commit --allow-empty -a -m "two files to remove" &&
+	chmod a-w xyzzy &&
+
+	git rm plugh xyzzy/plugh 2>msg &&
+
+	grep "git rm: '\''xyzzy/plugh'\'':" msg
+'
+! test -e xyzzy || chmod 775 xyzzy
+rm -fr expect actual plugh xyzzy
+
 test_expect_success '"rm" command printed' '
 	echo frotz > test-file &&
 	git add test-file &&
