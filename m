From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Can I forbid somebody to pull some branch or tag from my repo
 with git protocol?
Date: Wed, 17 Dec 2008 11:36:26 -0800
Message-ID: <7vd4fqoapx.fsf@gitster.siamese.dyndns.org>
References: <856bfe0e0812170103w1007cf4fs1e83e506c6dd909@mail.gmail.com>
 <7v1vw7p3r8.fsf@gitster.siamese.dyndns.org>
 <856bfe0e0812170115p73d72495ve81046127e68c281@mail.gmail.com>
 <alpine.DEB.1.00.0812171322330.28560@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Emily Ren <lingyan.ren@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 17 20:37:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD2DR-0000ub-V4
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 20:37:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbYLQTgg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 14:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbYLQTgg
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 14:36:36 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60211 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047AbYLQTgf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 14:36:35 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6B8198701F;
	Wed, 17 Dec 2008 14:36:32 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3AD6D8701C; Wed,
 17 Dec 2008 14:36:28 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0812171322330.28560@intel-tinevez-2-302>
 (Johannes Schindelin's message of "Wed, 17 Dec 2008 13:25:59 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 02156394-CC72-11DD-A257-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103374>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 17 Dec 2008, Emily Ren wrote:
>
>> I want some group can pull these branches or tags from my repo, while
>> other's can't, Need I maintain two repositories ?
>
> Either that (that would be the easy method, and also the proper one, since 
> people would not even know what you hide), but you could patch 
> upload-pack so that it runs a hook with the rev-list arguments in 
> do_rev_list() in upload-pack.c, and die() if the hook returns non-zero.

I do not think that would work very well as you expect.  Two branches can
be pointing at the same commit, and Emily may want to hide one but not the
other.  The time you obtain from "want" is too late.

If you were to extend upload-pack, the place to narrow would be the
initial "here are the refs and the objects they point at" announcement
that is done at the very beginning.  You would do something like the
pseudo patch attached at the end.

read_set_of_exposed_refs_from_hook() should return, depending on who the
user is (which is obviously not available if this connection is over the
anonymous git-daemon service, but local and usual ssh connection you could
do whoami, and on gitosis there would be some environment variable to
distinguish who you are that you can use), the set of refs that the user
is allowed to see.

diff --git i/upload-pack.c w/upload-pack.c
index e5adbc0..129aa1e 100644
--- i/upload-pack.c
+++ w/upload-pack.c
@@ -10,6 +10,10 @@
 #include "revision.h"
 #include "list-objects.h"
 #include "run-command.h"
+#include "string-list.h"
+
+static int use_ref_limiting;
+static struct string_list exposed_refs;
 
 static const char upload_pack_usage[] = "git-upload-pack [--strict] [--timeout=nn] <dir>";
 
@@ -574,8 +578,14 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
 	static const char *capabilities = "multi_ack thin-pack side-band"
 		" side-band-64k ofs-delta shallow no-progress"
 		" include-tag";
-	struct object *o = parse_object(sha1);
+	struct object *o;
+
+	if (use_ref_limiting && !string_list_has_string(&exposed_refs, refname)) {
+		/* The downloader is not allowed to know the presense of this ref */
+		return 0;
+	}
 
+	o = parse_object(sha1);
 	if (!o)
 		die("git upload-pack: cannot find object %s:", sha1_to_hex(sha1));
 
@@ -600,6 +610,12 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
 static void upload_pack(void)
 {
 	reset_timeout();
+
+	if ("limit exposed refs" hook is available) {
+		use_ref_limiting = 1;
+		read_set_of_exposed_refs_from_hook(&exposed_refs);
+	}
+
 	head_ref(send_ref, NULL);
 	for_each_ref(send_ref, NULL);
 	packet_flush(1);
