From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH v4 0/22] pack bitmaps
Date: Sat, 21 Dec 2013 19:34:59 +0100
Message-ID: <87d2kqm4rw.fsf@thomasrast.ch>
References: <20131221135651.GA20818@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 21 19:35:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VuROj-0004nm-7G
	for gcvg-git-2@plane.gmane.org; Sat, 21 Dec 2013 19:35:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754887Ab3LUSfE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Dec 2013 13:35:04 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:53924 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754727Ab3LUSfD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Dec 2013 13:35:03 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 13DC54D6572;
	Sat, 21 Dec 2013 19:35:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id NCqfU0xex74B; Sat, 21 Dec 2013 19:34:59 +0100 (CET)
Received: from hexa.thomasrast.ch (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 92B364D64C4;
	Sat, 21 Dec 2013 19:34:59 +0100 (CET)
In-Reply-To: <20131221135651.GA20818@sigill.intra.peff.net> (Jeff King's
	message of "Sat, 21 Dec 2013 08:56:51 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239626>

Jeff King <peff@peff.net> writes:

> Here's the v4 re-roll of the pack bitmap series.
>
> The changes from v3 are:
>
>  - reworked add_object_entry refactoring (see patch 11, which is new,
>    and patch 12 which builds on it in a more natural way)

This now looks like this (pasting because it is hard to see in the diffs):

  static int add_object_entry(const unsigned char *sha1, enum object_type type,
                              const char *name, int exclude)
  {
          struct packed_git *found_pack;
          off_t found_offset;
          uint32_t index_pos;

          if (have_duplicate_entry(sha1, exclude, &index_pos))
                  return 0;

          if (!want_object_in_pack(sha1, exclude, &found_pack, &found_offset))
                  return 0;

          create_object_entry(sha1, type, pack_name_hash(name),
                              exclude, name && no_try_delta(name),
                              index_pos, found_pack, found_offset);

          display_progress(progress_state, to_pack.nr_objects);
          return 1;
  }

  static int add_object_entry_from_bitmap(const unsigned char *sha1,
                                          enum object_type type,
                                          int flags, uint32_t name_hash,
                                          struct packed_git *pack, off_t offset)
  {
          uint32_t index_pos;

          if (have_duplicate_entry(sha1, 0, &index_pos))
                  return 0;

          create_object_entry(sha1, type, name_hash, 0, 0, index_pos, pack, offset);

          display_progress(progress_state, to_pack.nr_objects);
          return 1;
  }


Much nicer.  Thanks for going the extra mile!

-- 
Thomas Rast
tr@thomasrast.ch
