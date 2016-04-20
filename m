From: Shin Kojima <shin@kojima.org>
Subject: [PATCH] gitweb: apply fallback encoding before highlight
Date: Wed, 20 Apr 2016 20:32:28 +0900
Message-ID: <1461151948-38583-1-git-send-email-shin@kojima.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christopher Wilson <cwilson@cdwilson.us>,
	Jakub Narebski <jnareb@gmail.com>,
	Shin Kojima <shin@kojima.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 13:32:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asqNA-0001ha-Bm
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 13:32:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754304AbcDTLck convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Apr 2016 07:32:40 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33937 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752974AbcDTLcj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 07:32:39 -0400
Received: by mail-pa0-f49.google.com with SMTP id r5so15555780pag.1
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 04:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kojima-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qFM1wSUOysSlu1HYgfqkYxE8LwNcHnmRtj3ToQmi2go=;
        b=J///2LTuT8gf0cmWx2QEB1qVagxTTMvnpM53tzgOWrVfExMZP6yqGrTyFzXz9q0kBY
         J+eAqBEQz5jSG8dHMTdwhLrTvU72dNF6jV8qgJFOc9PIWed6JQu9maKHXjw6kgGyar2D
         efbX8BpugC1aSBxE75m4ALwFVRqdEDaGSGK/de5FBYTYIzuLOnyiGh30PS4nF5759wSK
         Cco7zILETHxGE3xKglo7/TNl+BWNyFr8r4jOTa3cJNVXc/wbWXjTIjOuhBoJ7qTW/TmB
         /liPAagBOknRO1Sgdx7AsbdT63a/X8hNWw6z/WhZgRHVy0NEBWkifDX/sxCsuBE1EVGh
         JwKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qFM1wSUOysSlu1HYgfqkYxE8LwNcHnmRtj3ToQmi2go=;
        b=TfnqgIAwBPh+Q3wmdroTqDUjHJZQI0lJe6qYuX2oXd2+0ZXTtSVMFIcYGjIEkEV2KI
         ZudM+GSH2jcQQRKmXrSNtWkaplc/rO0+oRpufpDqctQyn25QZkS+u2VT1NCgPETLwYdH
         QRMQrSzjgQApQmN4Z40e4+6HfyKZ3Rgu+cqtxUq/+4fnRfCIiyNM9XKkmGJvDazji99K
         Jrt8rvEHWUEhroD631J3YtDrx7T6NYG0tFQSKy+iY0rS4JLhr4fa5tE9FSPFRRFL+UiD
         N92MtXvwFMvmNmbPAZpvGjEyyVBio1LzbqtvqzCkuk6YcgqQB3i1BlNXvGLb0P+k6cV9
         E6Lg==
X-Gm-Message-State: AOPr4FVSm8EHWSx/aOrGtX9Xnz75ydhhOxuSb8Ju/YZjVruAMib/E0I/RBrNhyPh8od80g==
X-Received: by 10.66.121.197 with SMTP id lm5mr11455755pab.143.1461151958938;
        Wed, 20 Apr 2016 04:32:38 -0700 (PDT)
Received: from localhost.localdomain (pl340.nas82p.p-tokyo.nttpc.ne.jp. [210.139.27.84])
        by smtp.gmail.com with ESMTPSA id 9sm97743339pfm.10.2016.04.20.04.32.36
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 20 Apr 2016 04:32:38 -0700 (PDT)
X-Mailer: git-send-email 2.8.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292003>

Some multi-byte character encodings (such as Shift_JIS and GBK) have
characters whose final bytes is an ASCII '\' (0x5c), and they
will be displayed as funny-characters even if $fallback_encoding is
correct.  This is because `highlight` command always expects UTF-8
encoded strings from STDIN.

    $ echo 'my $v =3D "=E7=94=B3";' | highlight --syntax perl | w3m -T =
text/html -dump
    my $v =3D "=E7=94=B3";

    $ echo 'my $v =3D "=E7=94=B3";' | iconv -f UTF-8 -t Shift_JIS | hig=
hlight \
        --syntax perl | iconv -f Shift_JIS -t UTF-8 | w3m -T text/html =
-dump

    iconv: (stdin):9:135: cannot convert
    my $v =3D "

This patch prepare git blob objects to be encoded into UTF-8 before
highlighting in the manner of `to_utf8` subroutine.
---
 gitweb/gitweb.perl | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 05d7910..2fddf75 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3935,6 +3935,9 @@ sub run_highlighter {
=20
 	close $fd;
 	open $fd, quote_command(git_cmd(), "cat-file", "blob", $hash)." | ".
+	          quote_command($^X, '-CO', '-MEncode=3Ddecode,FB_DEFAULT', '=
-pse',
+	            '$_ =3D decode($fe, $_, FB_DEFAULT) if !utf8::decode($_);=
',
+	            '--', "-fe=3D$fallback_encoding")." | ".
 	          quote_command($highlight_bin).
 	          " --replace-tabs=3D8 --fragment --syntax $syntax |"
 		or die_error(500, "Couldn't open file or run syntax highlighter");
--=20
2.8.1
