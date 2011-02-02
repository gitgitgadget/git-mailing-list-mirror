From: Junio C Hamano <gitster@pobox.com>
Subject: Q: does index-pack work in place on windows?
Date: Wed, 02 Feb 2011 12:21:05 -0800
Message-ID: <7v39o6xk5q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Feb 02 21:21:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkjCg-0003yi-LP
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 21:21:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752561Ab1BBUVU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Feb 2011 15:21:20 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58077 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585Ab1BBUVU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Feb 2011 15:21:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6A2203594;
	Wed,  2 Feb 2011 15:22:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=CUY4
	0JMV1TlQelxopcyg888gYLs=; b=pZTeAXayCybs9bbQru24EqsD5hslSKN70HyE
	mwn6F4NtyqxtIHA/zrpbEKcJoj2K/+hQOqs/PR1TWia8hYtQX06y8UfVokiVX+Sd
	4Td2/YdT12Oez4pBetzT9OeS+e4K7jMNwB7B4koW7WUsl6QmvSEY6CedHcKBSauP
	WZVKlPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:from:date:message-id:mime-version:content-type; q=dns; s=sasl; b=
	JQyLqUILh9j8ZH3dy/Ss0djZcatAOOUI4vvpKqHCYIkJiispxr72xx67XLiBd3+N
	bwrQhcbUIR0gU+/nMNgsW/T67oNBwFDIdGG7YWoQfajduWlfHE+59kwKU4YIfgwR
	Iy1magdtrBzQfEFmQ+b2JATjLj5TjmKnq+sptRB8WLc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 38B3F3593;
	Wed,  2 Feb 2011 15:22:08 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4F4EF358C; Wed,  2 Feb 2011
 15:22:00 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1BB160DA-2F0A-11E0-98C3-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165934>

... or any other (operating / file) system where you cannot unlink a file
that is open?

When you run

    $ git clone git://some.where/repo/sitory.git local
    $ cd local
    $ git index-pack .git/objects/pack/pack-*.pack

there is a call to write_idx_file() in builtin/index-pack.c, that feeds
the correct (and existing) name of the corresponding pack idx file.

The callee in pack-write.c, after sorting the list of objects contained in
the pack, does this:

	if (!index_name) {
		static char tmpfile[PATH_MAX];
		fd = odb_mkstemp(tmpfile, sizeof(tmpfile), "pack/tmp_idx_XXXXXX");
		index_name = xstrdup(tmpfile);
	} else {
		unlink(index_name);
		fd = open(index_name, O_CREAT|O_EXCL|O_WRONLY, 0600);
	}
 
and then writes out the pack index to the file descriptor.  But index-pack
uses the usual has_sha1_file() and read_sha1_file() interface to validate
the "existing" objects, and is likely to have mmapped the .idx file when
it called use_pack_window().  Which makes me suspect that this unlink (or
the open that immediately follows) may fail on systems that do not allow
unlink on inode that has still users.
