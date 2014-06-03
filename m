From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v11 00/41] Use ref transactions
Date: Tue, 3 Jun 2014 11:31:24 -0700
Message-ID: <20140603183124.GD30019@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 20:31:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrtUi-0000NQ-Dp
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 20:31:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755127AbaFCSb2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 14:31:28 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:64663 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753937AbaFCSb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 14:31:27 -0400
Received: by mail-pd0-f182.google.com with SMTP id r10so5026980pdi.27
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 11:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=yjPIhhlRjYwTFkZx3tggSjz93/ODO3vmqJf9l1sjpcc=;
        b=TEy38SzWmgxZ5S7BizODBARGuijBkcfBRrzxDES+Bm6uBtAoqx8DFWlpvWm9h8U6D3
         s74fk+vNWsYs4qkoiV7dqZ6WqPcgSGsZEaqZ5rjWEfX36pXa2R/dQoyo8+wdkuKV+KCf
         xVvD5bBZNrP0dqfSfA9wXYw2HDzE38ZEaOZJ2qJ5jZ7VmeiQ+Et1sSvtcG/ezotaf3Gn
         2kfuSVi9D7XeyrDcDcPndn0Q3u4HjKHQCYsHR3ezrXpwAO7i/vDbG/d3LLobUOmKKPsP
         xtjx0C6pwzMFxGFtIYHO7Qw0iMCGugbQvaPPfmxeceB3KLSzxhqD969XCCIOJ4pTWhJw
         vkEA==
X-Received: by 10.69.31.202 with SMTP id ko10mr48554297pbd.23.1401820287475;
        Tue, 03 Jun 2014 11:31:27 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id jh2sm30774880pbd.93.2014.06.03.11.31.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 03 Jun 2014 11:31:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1401222360-21175-1-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250638>

Hi,

Ronnie Sahlberg wrote:

>                                                                        It
> converts all ref updates, inside refs.c as well as external, to use the
> transaction API for updates. This makes most of the ref updates to become
> atomic when there are failures locking or writing to a ref.

I'm still excited about this series.  Most of it looks ready.  The
remaining problems I see fall into a few categories:

 * The rename_ref codepath is strange.  You've convinced me that the
   approach you're taking there is not much of a regression, but it's
   confusing enough that I'd be happier if someone else takes a closer
   look (or I can try to find time to).

 * I think the approach taken in the patch "add transaction.status and
   track OPEN/CLOSED/ERROR" is a mistake and would make callers more
   error-prone.  The basic idea of checking that the caller is using
   the API right is valuable, so there is something in that patch I
   really like --- it's just the details (involving the same kind of
   easy-to-clobber error messages as errno provides with stdio) that
   seem broken.

   I suspect I'm just not communicating very well there.  Maybe
   mhagger or someone else could give it a sanity check.

 * Some commit messages (e.g., the one to "pack all refs before we
   start to rename a ref") are confusing.  That might be a sign that
   what those patches are trying to do is confusing.

 * The error handling in "add an err argument to repack_without_refs"
   is a thorny thicket.  It still has bugs.  I can completely
   understand not wanting to take that on but I think it is important
   to add a NEEDSWORK comment describing the known bugs to help people
   when they work with this code in the future.

I realize the process of addressing review comments in such a long
series has been a bit of a pain, and if there's anything I can do to
make it easier please let me know.  Hopefully adding some other
reviewers can help.

Thanks,
Jonathan
