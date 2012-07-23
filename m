From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] Make sure to use Araxis' "compare" and not e.g. ImageMagick's
Date: Tue, 24 Jul 2012 01:09:12 +0200
Message-ID: <500DD998.2020600@gmail.com>
References: <500CF8CE.90906@gmail.com> <500CF9D2.30102@gmail.com> <500CFB19.6010905@gmail.com> <7vmx2qmnfw.fsf@alter.siamese.dyndns.org> <500DA7F3.3000403@gmail.com> <7v4noykxvm.fsf@alter.siamese.dyndns.org> <CAHGBnuOz94YR9wx_goL5YaWzPt5Z9c3gBB9CtyfcE40F5amrXw@mail.gmail.com> <7v629ejexo.fsf@alter.siamese.dyndns.org> <7vtxwyhzi8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 01:09:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StRki-0000Bw-Sq
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 01:09:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754020Ab2GWXJT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 19:09:19 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:60651 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055Ab2GWXJS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 19:09:18 -0400
Received: by wgbdr13 with SMTP id dr13so6297107wgb.1
        for <git@vger.kernel.org>; Mon, 23 Jul 2012 16:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=O17i8JGtfIA9CoTjZuF5Z612KipVlWlU9jFaHBR/6Ys=;
        b=qbX2OAntUMwazOQZSgDP5XtKRzDjmVK36ZPE/YniZYjQ7hqLYUTishCVKXA7KIkij7
         Dj2w8k8+wI7HwjvZPlpD9kWfkkSJJfMLpWawZkSXof4TtCHQ+4Ph38I0U1O0iqnfbgdV
         YSY6j1hbB/TG7ZhaW0u35nsmyOADuLXTPEH8clX2nRAdFL8PuDDooaG0NNcS61QnAZrA
         cIBfbw9gXBCm4qYOODzq/CF6v4FiebTvI+z+MWN+8o1ENVIiZE8mBzBYaCVS3GmkaG8J
         0JIswSVCuGgghFaLC1ZtZfzI+QTqWyDoihcD800heI4Hlxaqc4OWAP4tDbKNJ68viAtF
         FstA==
Received: by 10.180.83.106 with SMTP id p10mr1412461wiy.21.1343084957662;
        Mon, 23 Jul 2012 16:09:17 -0700 (PDT)
Received: from [192.168.178.22] (p5DDB0643.dip0.t-ipconnect.de. [93.219.6.67])
        by mx.google.com with ESMTPS id t8sm1198481wiy.3.2012.07.23.16.09.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 23 Jul 2012 16:09:17 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <7vtxwyhzi8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202000>

On 24.07.2012 00:41, Junio C Hamano wrote:

> +		if test -f $(dirname "$(type --path compare)")/AraxisMerge

We would need additional quotes around the whole path here as the Windows installation path is usually something like "C:\Program Files\Araxis\Araxis Merge" and contains spaces.

Moreover, "test -f" requires the ".exe" extension to be explicitly present for the file to test. But I'd rather not do that because the test would be specific to Windows then and e.g. not work on Mac OS X. That's why I'd still like to use ls like in my first patch:

 mergetools/araxis | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/mergetools/araxis b/mergetools/araxis
index 64f97c5..c406ead 100644
--- a/mergetools/araxis
+++ b/mergetools/araxis
@@ -16,5 +16,18 @@ merge_cmd () {
 }
 
 translate_merge_tool_path() {
-	echo compare
+	case "$BASH_VERSION" in
+	??*)
+		# we can safely use "type --path"
+		if ls "$(dirname "$(type --path compare)")"/Araxis* >/dev/null 2>&1
+		then
+			echo compare
+		else
+			echo "$1"
+		fi
+		;;
+	*)
+		echo compare
+		;;
+	esac
 }

-- 
Sebastian Schuberth
