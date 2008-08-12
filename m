From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/3] Git.pm: Add faculties to allow temp files to be cached
Date: Mon, 11 Aug 2008 20:08:09 -0700
Message-ID: <20080812030809.GA14051@untitled>
References: <489DBB8A.2060207@griep.us> <1218470035-13864-1-git-send-email-marcus@griep.us> <1218470035-13864-2-git-send-email-marcus@griep.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Marcus Griep <marcus@griep.us>
X-From: git-owner@vger.kernel.org Tue Aug 12 05:11:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSkId-0007EV-CG
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 05:11:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbYHLDIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 23:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbYHLDIM
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 23:08:12 -0400
Received: from hand.yhbt.net ([66.150.188.102]:33132 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751200AbYHLDIL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 23:08:11 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id D535E2DC01B;
	Mon, 11 Aug 2008 20:08:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1218470035-13864-2-git-send-email-marcus@griep.us>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92063>

Marcus Griep <marcus@griep.us> wrote:
> This patch offers a generic interface to allow temp files to be
> cached while using an instance of the 'Git' package. If many
> temp files are created and destroyed during the execution of a
> program, this caching mechanism can help reduce the amount of
> files created and destroyed by the filesystem.
> 
> There are two methods offered for creating a new file: a no-lock and
> a acquire-lock version. The no-lock version provides no
> guarantee that a file is not in use or that the temp file may be
> stolen by a subsequent request. The acquire-lock version provides a
> weak guarantee that a temp file will not be stolen by subsequent
> requests even from a no-lock request. If a file is locked when
> another acquire request is made, a simple error is thrown.

I'm not sure if the no-lock version is worth the potential for
buggy or dangerous code.  I like this new idea of locking the
files to prevent bugs.

> +=item temp_release ( NAME [, BOOL] )
> +
> +=item temp_release ( FILEHANDLE [, BOOL] )
> +
> +Releases a lock acquired through C<temp_acquire()>. Can be called either with
> +the C<NAME> mapping used when acquiring the temp file or with the C<FILEHANDLE>
> +referencing a locked temp file.
> +
> +Warns if an attempt is made to release a file that is not locked.
> +
> +If called with C<BOOL> true, then the temp file will be truncated before being
> +released. This can help to reduce disk I/O where the system is smart enough to
> +detect the truncation while data is in the output buffers.

Always truncating on release makes the interface simpler.  With locking,
we can probably *only* truncate on release if you're that worried about
the extra overhead :)

> +=item temp_reset ( FILEHANDLE )
> +
> +Truncates and resets the position of the C<FILEHANDLE>.  Uses C<sysseek>.
> +
> +=cut
> +
> +sub temp_reset {
> +	my ($self, $temp_fd) = _maybe_self(@_);
> +
> +	truncate $temp_fd, 0
> +		or throw Error::Simple("couldn't truncate file");

I would do a regular seek() here in addition to the sysseek() below. I
am not certain one of the many userspace buffering layers Perl can
potentially use doesn't do anything funky with its offset accounting.

> +	sysseek $temp_fd, 0, SEEK_SET
> +		or throw Error::Simple("couldn't seek to beginning of file");

I would also put a tell() here after the sysseek and throw an error if
it returns a non-zero value just in case.  Yes, I'm really paranoid
about this stuff and have a huge distrust of userspace I/O layers :)

-- 
Eric Wong
