From: Dirk Wallenstein <halsmit@t-online.de>
Subject: [PATCH v2] request-pull: improve error message for invalid revision
 args
Date: Wed, 17 Jul 2013 19:28:11 +0200
Message-ID: <20130717172811.GA12981@bottich>
References: <20130716104648.GA13275@bottich>
 <7vr4ex6rqq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 17 19:37:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzVfC-0002IF-6B
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 19:37:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932656Ab3GQRhM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jul 2013 13:37:12 -0400
Received: from mailout01.t-online.de ([194.25.134.80]:54167 "EHLO
	mailout01.t-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755426Ab3GQRhL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 13:37:11 -0400
Received: from fwd15.aul.t-online.de (fwd15.aul.t-online.de )
	by mailout01.t-online.de with smtp 
	id 1UzVWR-0002TT-3q; Wed, 17 Jul 2013 19:28:15 +0200
Received: from localhost (ZSG670ZT8hIvnN4wYXt+n7JoPe0iyhNg3Or-+Qed85j1SqCV5dl6hwvKzEuV76qw1w@[5.147.118.105]) by fwd15.t-online.de
	with esmtp id 1UzVWQ-2r2CBc0; Wed, 17 Jul 2013 19:28:14 +0200
Content-Disposition: inline
In-Reply-To: <7vr4ex6rqq.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ID: ZSG670ZT8hIvnN4wYXt+n7JoPe0iyhNg3Or-+Qed85j1SqCV5dl6hwvKzEuV76qw1w
X-TOI-MSGID: c62f5d94-cfee-461c-b716-3a34292a3231
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230639>

Currently, when an invalid revision is specified, the error message is:

    fatal: Needed a single revision

This is misleading because, you might think there is something wrong
with the command line as a whole.

Now the user gets a more meaningful error message, showing the invalid
revision.

Signed-off-by: Dirk Wallenstein <halsmit@t-online.de>
---

On Wed, Jul 17, 2013 at 10:06:21AM -0700, Junio C Hamano wrote:
> Dirk Wallenstein <halsmit@t-online.de> writes:
> > +baserev=$(git rev-parse --verify "$base"^0 2>/dev/null)
> 
> Use "--quiet" instead?
Oh, of course.

 git-request-pull.sh | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/git-request-pull.sh b/git-request-pull.sh
index d566015..ebf1269 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -51,8 +51,18 @@ fi
 tag_name=$(git describe --exact "$head^0" 2>/dev/null)
 
 test -n "$base" && test -n "$url" || usage
-baserev=$(git rev-parse --verify "$base"^0) &&
-headrev=$(git rev-parse --verify "$head"^0) || exit
+
+baserev=$(git rev-parse --verify --quiet "$base"^0)
+if test -z "$baserev"
+then
+    die "fatal: Not a valid revision: $base"
+fi
+
+headrev=$(git rev-parse --verify --quiet "$head"^0)
+if test -z "$headrev"
+then
+    die "fatal: Not a valid revision: $head"
+fi
 
 merge_base=$(git merge-base $baserev $headrev) ||
 die "fatal: No commits in common between $base and $head"
-- 
1.8.3.3.2.g85103ba
