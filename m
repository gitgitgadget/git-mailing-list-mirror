From: Marat Radchenko <marat@slonopotamus.org>
Subject: [BUG] git repack fails if .git/objects/pack is on a separate
 partition
Date: Mon, 18 Oct 2010 23:28:26 -0700 (PDT)
Message-ID: <1287469706023-5649732.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 19 08:28:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P85gY-0006tk-Vs
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 08:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933521Ab0JSG23 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Oct 2010 02:28:29 -0400
Received: from kuber.nabble.com ([216.139.236.158]:45485 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933459Ab0JSG21 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 02:28:27 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <marat@slonopotamus.org>)
	id 1P85gQ-00031v-1J
	for git@vger.kernel.org; Mon, 18 Oct 2010 23:28:26 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159306>


Console log:

Counting objects: 5137063, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (892984/892984), done.
fatal: unable to rename temporary pack file: Invalid cross-device link
error: failed to run repack

Reason:
write_pack_file in builtin/pack-objects.c first writes tmp file in
"pack/tmp_pack_XXXXXX". 

Then, it tries to rename it to "%s-%s.pack":

snprintf(tmpname, sizeof(tmpname), "%s-%s.pack",
                                 base_name, sha1_to_hex(sha1));
...
if (rename(pack_tmp_name, tmpname))
                                die_errno("unable to rename temporary pack
file");

and happily fails because that crosses device boundary. Same problem with
index file. Suggested fix: do those renames inside pack directory or avoid
them at all.
-- 
View this message in context: http://git.661346.n2.nabble.com/BUG-git-repack-fails-if-git-objects-pack-is-on-a-separate-partition-tp5649732p5649732.html
Sent from the git mailing list archive at Nabble.com.
