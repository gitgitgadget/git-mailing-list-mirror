From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] gitk: pass --invert-grep option down to "git log"
Date: Sun, 15 Feb 2015 23:29:10 -0800
Message-ID: <xmqqd25a71rt.fsf_-_@gitster.dls.corp.google.com>
References: <xmqq61cjo6lq.fsf@gitster.dls.corp.google.com>
	<1421112812-13578-1-git-send-email-ottxor@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Christoph Junghans <ottxor@gentoo.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Feb 16 08:29:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNG7J-0001dW-SN
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 08:29:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752130AbbBPH3O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2015 02:29:14 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57937 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751254AbbBPH3N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2015 02:29:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8EBD32BEA5;
	Mon, 16 Feb 2015 02:29:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7dWtjks+OTtxNhsczRXjGEofEB0=; b=W8UiT6
	ueWqBTfcT3dOvgD/064TcbH6v25OsFRDMZ1fQ042lsDV2/WW79hQNImVuEq71Jy2
	WrmNpQ4WUs0J+e4q/FcsW+SP9p0TJBE2PqT2ANp3o9gqzflWk5v8rXmhvtvMJPWj
	eZN0KnHUFakvEc++mIw8mvGQrTN0OiXPDyhnE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Hsa44Sy08F7SVshJ4QcwW8FeRwa8xuxY
	CDTQW3qIlhsq3eQtYJ0NuD3Ocr+254a4wtqrrPKcFwFwOct7xN22lmx1z6XEZlN6
	c58nbunhz//2/gkir8tVGyvs4REhe3kAn97kyTsSSygNZPl8Q8j5XbXSkAzwaXs4
	BSmTlqpt8YI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 867FE2BEA4;
	Mon, 16 Feb 2015 02:29:12 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0E28F2BEA3;
	Mon, 16 Feb 2015 02:29:11 -0500 (EST)
In-Reply-To: <1421112812-13578-1-git-send-email-ottxor@gentoo.org> (Christoph
	Junghans's message of "Mon, 12 Jan 2015 18:33:32 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 80AC2A5A-B5AD-11E4-8235-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263887>

From: Christoph Junghans <ottxor@gentoo.org>
Date: Mon, 12 Jan 2015 18:33:32 -0700

"git log --grep=<string>" shows only commits with messages that
match the given string, but sometimes it is useful to be able to
show only commits that do *not* have certain messages (e.g. "show
me ones that are not FIXUP commits").

Now the underlying "git log" learned the "--invert-grep" option.
The option syntactically behaves similar to "--all-match" that
requires that all of the grep strings to match and semantically
behaves the opposite---it requires that none of the grep strings to
match.

Teach "gitk" to allow users to pass it down to underlying "git log"
command by adding it to the known_view_options array.

Signed-off-by: Christoph Junghans <ottxor@gentoo.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Split from Christoph's original patch ($gmane/262313).

 gitk | 1 +
 1 file changed, 1 insertion(+)

diff --git b/gitk a/gitk
index 3520bda..a95a93f 100755
--- b/gitk
+++ a/gitk
@@ -4036,6 +4036,7 @@ set known_view_options {
     {committer t15  .  "--committer=*"  {mc "Committer:"}}
     {loginfo   t15  .. "--grep=*"       {mc "Commit Message:"}}
     {allmatch  b    .. "--all-match"    {mc "Matches all Commit Info criteria"}}
+    {igrep     b    .. "--invert-grep"  {mc "Matches none Commit Info criteria"}}
     {changes_l l    +  {}               {mc "Changes to Files:"}}
     {pickaxe_s r0   .  {}               {mc "Fixed String"}}
     {pickaxe_t r1   .  "--pickaxe-regex"  {mc "Regular Expression"}}
