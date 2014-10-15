From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 17/25] branch -d: simplify by using RESOLVE_REF_READING
Date: Tue, 14 Oct 2014 17:52:55 -0700
Message-ID: <20141015005255.GU32245@google.com>
References: <20141015004522.GD32245@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 15 02:53:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeCpq-0003It-Ai
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 02:53:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbaJOAw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2014 20:52:58 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:57155 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755841AbaJOAw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2014 20:52:58 -0400
Received: by mail-pd0-f179.google.com with SMTP id r10so232726pdi.10
        for <git@vger.kernel.org>; Tue, 14 Oct 2014 17:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=zsuDw3y/XqdkM3CzEtqWia8tjMTJ7DuoJsRReCVR7lY=;
        b=NOYkM8fXKwQKStT6rSA8G/yFKlPZptf59QrUfXhduSHOV1ArNZJIt1r2jzXM1cjmEv
         d1x2TlRyT/loFS6nGKRppnqAQ1PM9ywyqIhRCRvVqXKGJN3zSSna1r4b4QXdFbF8aBbT
         5epFO4gu1vLpoQPK9swtSpAUtoc82ShOHFSITTQagM0vP2ccMLd/tk1G649ou16IUViF
         8XBa6h004LahUaw4iQT8s7qscthxVsZC5vk5n7qKkCbjXEUP7CTv1f+2O3qibkz/cpvj
         RORKQwul0p2dPz0ZNohDFzAwYq7yKUELGI8GYg27GlamqMgGta8XREDy40avc9/QGX9r
         twKg==
X-Received: by 10.66.196.237 with SMTP id ip13mr8543230pac.80.1413334377846;
        Tue, 14 Oct 2014 17:52:57 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:c43b:1934:40ef:9a07])
        by mx.google.com with ESMTPSA id w8sm15339972pdo.61.2014.10.14.17.52.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 Oct 2014 17:52:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141015004522.GD32245@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/branch.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 2ad2d0b..0c7aac0 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -236,10 +236,11 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
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
