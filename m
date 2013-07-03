From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 0/3] Perl rewrite of Ruby git-related
Date: Wed,  3 Jul 2013 16:59:39 -0400
Message-ID: <1372885182-5512-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 03 23:00:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuUAY-0000Rz-3l
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 23:00:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933372Ab3GCVAu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 17:00:50 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:47738 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933311Ab3GCVAU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 17:00:20 -0400
Received: by mail-ob0-f175.google.com with SMTP id xn12so714734obc.20
        for <git@vger.kernel.org>; Wed, 03 Jul 2013 14:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=/ZUTfblI+lK0boJXMU82Q4YEFiOjvu6UUVMN157XGwE=;
        b=fHWVQvGBuLhdO7hokDdzkpEFICuEWUZxZP0jdwtqfXj5zzG9hrU6CMmtz9b+hJNPt+
         8sIMhs8+hhPrw9HQ0JufT+tFBXoBlnDRyVJADozsi3WuFHkYlLV7KD7nate/QtV/FrHt
         3zz0Z/r8pLvwp1viSc3Jcuk1GV3I/+WOIku9efZS85WATNx5fCpSwOlS/brXBjeMN2EV
         i3QhCuml7hb8BrL8ImI+z682jXFhhJRPo5A6hsg/HthyvPDgrs0QGAiinwYi6cTloZm1
         Fkx93BP6u4JsGSM8BQXs9ZvYxFLEzjg9OtiRrNqrzjtL1x0AnNDSFnMBv2dyP5D5QSfu
         V8yQ==
X-Received: by 10.182.165.133 with SMTP id yy5mr2703514obb.89.1372885220020;
        Wed, 03 Jul 2013 14:00:20 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id ps5sm14400579oeb.8.2013.07.03.14.00.18
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 03 Jul 2013 14:00:19 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229533>

This is v2 of the Perl rewrite of Felipe Contreras' git-related v9 patch
series[1] which was written in Ruby. v2 addresses (hopefully all of)
Junio's v1[2] review points.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/226065/
[2]: http://thread.gmane.org/gmane.comp.version-control.git/229266/


Changes since v1:

* Match Signed-off-by:, etc. labels case-insensitively.

* Recognize Cc: in addition to Signed-off-by: and other typical labels.

* Match SHA-1's and surrounding context more strictly in output of
  git-format-patch, git-blame, git-cat-file.

* Mention -C in commit message of [1/3].

* Pass just a single -C to git-blame and git-diff. Previously, git-blame
  was invoked inconsistently with '-C -C' and git-diff with '-C'.

* Employ git-blame --porcelain rather than --incremental.

* Fix bug where a "new file" ('--- /dev/null') hunk following a "changed
  file" ('--- a/path/to/file') hunk would incorrectly invoke git-blame
  on "changed file" with line numbers from "new file".

* Fix bug where filename containing whitespace was not recognized
  correctly when scanning hunk source lines ('--- /a/file name').

* Abort when unable to parse hunk source ('--- path') from diff with
  custom --src-prefix=.

* Emit diagnostic, rather than exiting silently, when user neglects to
  provide input arguments.

* Combine v1 patches [1/4] and [2/4]. As Junio pointed, a single patch
  file may contain multiple patches (for example "git format-patch
  --stdout -4 >P.mbox"), so the machinery for dealing with multiple
  patches must already be present in [1/4] whether the patches come from
  one file or many. Consequently, adding "multiple file" support
  involved only a very minor change to @ARGV handling, not deserving of
  a separate [2/4] patch.

* Drop Perl source file and line number information from user-facing
  error messages.


Possible future directions and considerations:

* Add mailmap support.

* Make participation parameters (minimum-percent, blame since-date, -C
  level) configurable.

* Optimize by coalescing ranges into a single git-blame -L invocation;
  or enhance git-blame to accept multiple -L's.

* Improve Windows support if needed, possibly via grabbing
  run_cmd_pipe() from git-add--interactive.perl or similar.


Eric Sunshine (3):
  contrib: add git-contacts helper
  contrib: contacts: add ability to parse from committish
  contrib: contacts: interpret committish akin to format-patch

 contrib/contacts/git-contacts | 170 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 170 insertions(+)
 create mode 100755 contrib/contacts/git-contacts

-- 
1.8.3.2
