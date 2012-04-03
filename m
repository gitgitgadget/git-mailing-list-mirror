From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/9] Prefix-compress on-disk index entries
Date: Tue,  3 Apr 2012 15:53:07 -0700
Message-ID: <1333493596-14202-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 04 00:53:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFCbM-0006ha-1j
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 00:53:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754841Ab2DCWxT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 18:53:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55879 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754775Ab2DCWxS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 18:53:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 302B87F60
	for <git@vger.kernel.org>; Tue,  3 Apr 2012 18:53:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=0TqbQ2YskJTH+utts9UqQfzUWcM
	=; b=EncSubhXKNkpG6wBjqknrgEAIyVRZFwB62mdHNGb6OhFmvm4sqJimjegi0A
	NvToRnKrv3JUlbaZ6sQG85Pf1K+pNdQJNPfljjzkE3YZWF52Gq+K5ZhWFeiZnMrD
	Igff3ZJhu9futyr0YoF7+2rZM5TGRt8kOyP9Ja7AieK0CBLE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=He5Y7GyVAGhfTydUd55VgRaUzyWqL
	t6aTW58kaGuyQh9dLULP3/PjFuNbqjejEeclmKjGUqtx+s2BQ9wa1YW46O4i4awp
	ZjEobB3xdG4cLtcgzgjZE3GKwqeDiVKAWXlquIKo+7cilEMS1/K0LTAMwIstxeYr
	CKejWyI3OlZow4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 241B37F5F
	for <git@vger.kernel.org>; Tue,  3 Apr 2012 18:53:18 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 925837F5E for
 <git@vger.kernel.org>; Tue,  3 Apr 2012 18:53:17 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.rc4.54.g1d5dd3
X-Pobox-Relay-ID: CD7673EE-7DDF-11E1-9E14-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194660>

This is still rough, but with this patch I am getting:

    $ ls -l .git/index*
    -rw-r----- 1 jch eng 25586488 2012-04-03 15:27 .git/index
    -rw-r----- 1 jch eng 14654328 2012-04-03 15:38 .git/index-4

in a clone of WebKit repository that has 183175 paths.

With hot-cache with no local modification:

    $ time sh -c 'GIT_INDEX_FILE=.git/index-4 git diff'
    real  0m0.469s
    user  0m0.130s
    sys   0m0.330s

    $ time sh -c 'git diff'
    real  0m0.677s
    user  0m0.290s
    sys   0m0.370s

which is mesuring the time needed to read of the index into in-core
structure and comparing the cached stat information taken from lstat(2).

The updated format is not documented yet, as I didn't intend (and I still
am not committed) to declare a change along this line the official "v4"
format; I was merely being curious to see how much improvements we can get
from a trivial approach like this.

The saving of the on-disk index size comes from two factors:

 - Not padding the on-disk index entries to 8-byte boundary;

 - Not storing the full pathname for each entry in the on-disk format.

Because the entries are sorted by path, adjacent entries in the index tend
to share the leading components of them, and it makes sense to only store
the differences in later entries.  In the v4 on-disk format of the index,
each on-disk cache entry stores the number of bytes to be stripped from
the end of the previous name, and the bytes to append to the result, to
come up with its name.

The "to-remove" count is encoded in the varint format used in the
packfiles, and the "bytes-to-append" is a simple NUL-terminated string.

Junio C Hamano (9):
  varint: make it available outside the context of pack
  cache.h: hide on-disk index details
  read-cache.c: allow unaligned mapping of the index file
  read-cache.c: make create_from_disk() report number of bytes it consumed
  read-cache.c: report the header version we do not understand
  read-cache.c: move code to copy ondisk to incore cache to a helper function
  read-cache.c: move code to copy incore to ondisk cache to a helper function
  read-cache.c: read prefix-compressed names in index on-disk version v4
  read-cache.c: write index v4 format

 Makefile               |    2 +
 builtin/update-index.c |    2 +
 cache.h                |   52 +---------
 config.c               |   11 ++
 environment.c          |    1 +
 read-cache.c           |  259 ++++++++++++++++++++++++++++++++++++++++--------
 varint.c               |   29 ++++++
 varint.h               |    9 ++
 8 files changed, 275 insertions(+), 90 deletions(-)
 create mode 100644 varint.c
 create mode 100644 varint.h

-- 
1.7.10.rc4.54.g1d5dd3
