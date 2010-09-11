From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 7/8] setup_tree_pathspec(): interpret '^' as negative pathspec
Date: Sat, 11 Sep 2010 11:29:00 -0600
Message-ID: <AANLkTin_m+zjHND5AwFhkrZM-VEkn70qgCTwpB2B+RA+@mail.gmail.com>
References: <1283961023-4491-1-git-send-email-pclouds@gmail.com>
	<1283961023-4491-8-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 11 19:29:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OuTsy-0006RO-BN
	for gcvg-git-2@lo.gmane.org; Sat, 11 Sep 2010 19:29:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754028Ab0IKR3D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Sep 2010 13:29:03 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59128 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753541Ab0IKR3B convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Sep 2010 13:29:01 -0400
Received: by bwz11 with SMTP id 11so3290597bwz.19
        for <git@vger.kernel.org>; Sat, 11 Sep 2010 10:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1NfvJR97WDx1ILoopyQc8S3oulAuIH6BaJIGHW/T/R0=;
        b=Kv6Bb5JIL3XtgKfa0HVzuBhVrkS6lRn0roBSosFMdmFKgfjpRx9JmqPyi0y8vsIk2Y
         yjPzPHj6LmKXRqaZerZPjFwkqERMPCdq1mS9GvSqLZb7fNk1cXLanDApDGgC2cTbawJ1
         I+qy0BSLGfjkWCdm6ro+tIIgj5VLTraaw1bJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vjxZjXayXYln8BIlLlUpQh6cyHfgLZD0/XLAqWz70+aDbdya/hjdPPSDPVc8cr/H1a
         8+euYrNwgIIwdsY7EPS6xwfjuEc7lDhAQ8cqRrMZ6DghbzLXIhJ66gxUWixsupooJAsD
         rUxfc7SGfgagApTevRki4ZAdmJwI+fNN1FGXQ=
Received: by 10.204.56.84 with SMTP id x20mr1686151bkg.68.1284226140547; Sat,
 11 Sep 2010 10:29:00 -0700 (PDT)
Received: by 10.204.126.198 with HTTP; Sat, 11 Sep 2010 10:29:00 -0700 (PDT)
In-Reply-To: <1283961023-4491-8-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155999>

2010/9/8 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>:
> This patch does preparation work for tree exclusion in
> tree_entry_interesting(). '^' has similar meaning to '!' in
> gitexcludes. '!' is not used because bash does not like arguments wit=
h
> a leading '!'.
>
> Eventually, "git diff -- foo ^foo/bar" should show differences in foo=
,
> except foo/bar. If "git diff -- ^foo" is given, then it implies
> everything except foo, which could surprise users that
> "bar" in "git diff -- bar ^foo" has no effect at all.

I really like the work here.  There are just two things that I think
are missing:
  * It doesn't handle files with leading carats in their name
  * It handles some nested include/exclude cases (e.g. dir
^dir/subdir) but not more complicated ones.

You could add these three testcases (on top of your 8/8 patch) to see
what I mean:


test_expect_failure 'diff ^one one/two' '
	printf "file\none/two/file\n" >expected &&
	git diff --name-only HEAD^ HEAD -- ^one one/two >result &&
	test_cmp expected result
'

test_expect_failure 'diff ^funny-filename' '
	touch ^funny-filename &&
	git add ^funny-filename &&
	git commit -m "Add a filename with a leading carat" &&

	git ls-files >expected &&
	git diff --name-only HEAD^^ HEAD -- ^funny-filename >result &&
	test_cmp expected result &&

	echo ^funny-filename >expected &&
	git diff --name-only HEAD^^ HEAD -- ^^funny-filename >result &&
	test_cmp expected result &&

	git ls-files | grep -v funny-filename >expected &&
	git diff --name-only HEAD^^ HEAD -- ^^^funny-filename >result &&
	test_cmp expected result
'

test_expect_failure 'deeper nested exclude/include' '
	touch one/two/zoo &&
	for i in one/file one/zoo one/two/file; do echo 2 >>$i; done &&
	git add one &&
	git commit -m 4 &&

	printf "one/file\none/two/file\none/zoo\n" > expected &&
	git diff --name-only HEAD^ HEAD -- one ^one/two one/two/file >result &=
&
	test_cmp expected result &&

	printf "one/two/zoo\n" > expected &&
	git diff --name-only HEAD^ HEAD -- ^one one/two ^one/two/file >result =
&&
	test_cmp expected result
'

Note: In the second test, I used:
 * "^funny" to search for all files EXCEPT "funny"
 * "^^funny" to search for a file named "^funny"
 * "^^^funny" to search for all files EXCEPT "^funny"
I'm not sure if that's really the syntax we want to adopt, but it
should be easy to change if we decide on some other syntax.
