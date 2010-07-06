From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCHv2 5/5] fast-import: Fix minor data-loss issue with
	directories becoming symlinks
Date: Tue, 6 Jul 2010 12:34:55 -0700
Message-ID: <20100706193455.GA19476@spearce.org>
References: <1278442295-23033-1-git-send-email-newren@gmail.com> <1278442295-23033-6-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, agladysh@gmail.com
To: newren@gmail.com
X-From: git-owner@vger.kernel.org Tue Jul 06 21:35:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWDv9-0003yP-H9
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 21:35:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755737Ab0GFTfA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 15:35:00 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:49006 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755651Ab0GFTe7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 15:34:59 -0400
Received: by pxi14 with SMTP id 14so2321204pxi.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 12:34:58 -0700 (PDT)
Received: by 10.142.224.7 with SMTP id w7mr6385242wfg.84.1278444898225;
        Tue, 06 Jul 2010 12:34:58 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id 21sm6234289wfi.5.2010.07.06.12.34.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 06 Jul 2010 12:34:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1278442295-23033-6-git-send-email-newren@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150403>

newren@gmail.com wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> When fast-export runs across a directory changing to a symlink, it will
> output the changes in the form
>   M 120000 :239821 dir-changing-to-symlink
>   D dir-changing-to-symlink/filename1
> When fast-import sees the first line, it deletes the directory named
> dir-changing-to-symlink (and any files below it) and creates a symlink in
> its place.  When fast-import came across the second line, it was previously
> trying to remove the file and relevant leading directories in
> tree_content_remove(), and as a side effect it would delete the symlink
> that was just created.  This resulted in the symlink silently missing from
> the resulting repository.

Ugh.

I'm not against making the input parser more robust, but this is
a violation of the stream format from fast-export.  The stream is
incremental, a command like 'M' takes place immediately.  It is
wrong for a frontend to output 'M foo', then 'D foo/bar'.

IMHO, if fast-export is doing what you say above, the bug lies in
fast-export, and therefore the fix should too.
 
-- 
Shawn.
