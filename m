From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 16/24] branch -d: simplify by using RESOLVE_REF_READING flag
Date: Wed, 1 Oct 2014 19:15:54 -0700
Message-ID: <20141002021554.GI1175@google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
 <CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
 <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
 <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
 <20140820231723.GF20185@google.com>
 <20140911030318.GD18279@google.com>
 <20141002014817.GS1175@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 04:16:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZVw4-0004Qb-Vk
	for gcvg-git-2@plane.gmane.org; Thu, 02 Oct 2014 04:16:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbaJBCP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 22:15:58 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:48779 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868AbaJBCP5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2014 22:15:57 -0400
Received: by mail-pa0-f47.google.com with SMTP id rd3so1375381pab.20
        for <git@vger.kernel.org>; Wed, 01 Oct 2014 19:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=WSgUOWe6vk8bhCpYnYQVSm9J+gtBbCg3KhEN4rrgUDE=;
        b=M623LuTi8742LCMtjLoLJXk0Uuzwh92QBsMMNNPalFVev/8u7pQ+w3F6ByshQwSnS8
         uumq2FQagyH4oU2qNMIbT35ifgwL25OYVbGJpEEmUuJNkxJFz7w2x67ymbNcNEXSF5Fi
         CKiDmq+LuPVYOFnlKQE90FiaGYy6VmQuVk4sJ7BNcnLF8L4QDOc6JDPsnDMs3seHC6V0
         08gdH5T/MdCpsn6Or6FR3T97Hcz+apwLFtypv98DO39NFkifN13QnO5WDgVbpNp2cHd2
         oMtbD+0TDeTt5g62N1FpGgpbFaj+ncWCO0srRSHwoSVTE+JbalBdH4lm2/tpdtkHkef7
         XG+A==
X-Received: by 10.67.4.230 with SMTP id ch6mr82965362pad.109.1412216157565;
        Wed, 01 Oct 2014 19:15:57 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id po6sm2099969pbb.56.2014.10.01.19.15.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 01 Oct 2014 19:15:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141002014817.GS1175@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257787>

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Thu, 11 Sep 2014 10:34:36 -0700

When "git branch -d" reads the branch it is about to delete, it used
to avoid passing the RESOLVE_REF_READING ('treat missing ref as
error') flag because a symref pointing to a nonexistent ref would show
up as missing instead of as something that could be deleted.  To check
if a ref is actually missing, we then check

 - is it a symref?
 - if not, did it resolve to null_sha1?

Now we pass RESOLVE_REF_NO_RECURSE and the correct information is
returned for a symref even when it points to a missing ref.  Simplify
by relying on RESOLVE_REF_READING.

No functional change intended.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Split out from the 'fix handling of badly named refs' patch.

 builtin/branch.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index a334380..a0c5601 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -234,10 +234,11 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		free(name);
 
 		name = mkpathdup(fmt, bname.buf);
-		target = resolve_ref_unsafe(name, RESOLVE_REF_NO_RECURSE,
+		target = resolve_ref_unsafe(name,
+					    RESOLVE_REF_READING
+					    | RESOLVE_REF_NO_RECURSE,
 					    sha1, &flags);
-		if (!target ||
-		    (!(flags & REF_ISSYMREF) && is_null_sha1(sha1))) {
+		if (!target) {
 			error(remote_branch
 			      ? _("remote branch '%s' not found.")
 			      : _("branch '%s' not found."), bname.buf);
-- 
2.1.0.rc2.206.gedb03e5
