From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/7] [GSoC2009] Revision cache / git-daemon caching plan
Date: Fri, 05 Jun 2009 09:56:27 -0700 (PDT)
Message-ID: <m34ouu7h70.fsf@localhost.localdomain>
References: <cover.1244125127.git.sam@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nick Edelen <sirnot@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	Jeff King <peff@peff.net>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Fri Jun 05 18:56:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCcij-00016P-2C
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 18:56:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754770AbZFEQ4a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 12:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754398AbZFEQ4a
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 12:56:30 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:64282 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754272AbZFEQ43 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 12:56:29 -0400
Received: by fxm9 with SMTP id 9so710775fxm.37
        for <git@vger.kernel.org>; Fri, 05 Jun 2009 09:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=yLkZ/NUKB3jJ2jC9pCpueGA0J5n5Ui3rC5q6NMruQqE=;
        b=guBxuJiN9P90KhG0NYQQ+6wbJUNzgyRaciyly84cBHk0Biw96bxV2+U80y9pPDOdss
         WvoUmQxy59lvAddVCi3lz4Cz2dq7z+IURoyo7Nt4XLbANY9zaiuuqC4XnwNCCQeG1Ecs
         zKOiUkA+YEIqvKlQZlYSnG4kROZHpZLeZXAqY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=gEGfCNV+A8fjrVr9oRYKEzmbVkLxCjnQWZU9qycsWnyxwXO+56SzbicK2za1ozmIkq
         2cETjSXOAqmPC81VLAr6jrwUaU9ohF8dNFjVYEVg/VIVsSjYIYPVHBS1skk+mUkrM2W8
         xTpSOx+GJOAyXjSCl2JOqZcsNLE8yqivzD0RA=
Received: by 10.86.3.11 with SMTP id 11mr4129300fgc.11.1244220988706;
        Fri, 05 Jun 2009 09:56:28 -0700 (PDT)
Received: from localhost.localdomain (abwo21.neoplus.adsl.tpnet.pl [83.8.238.21])
        by mx.google.com with ESMTPS id 12sm383948fgg.20.2009.06.05.09.56.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Jun 2009 09:56:27 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n55GuPon021705;
	Fri, 5 Jun 2009 18:56:25 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n55GuKXD021702;
	Fri, 5 Jun 2009 18:56:20 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <cover.1244125127.git.sam@vilain.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120810>

Sam Vilain <sam@vilain.net> writes:

> This patch series describes the structure of the object list cache
> on-disk format.  It is built successively from a very simple design -
> just an object list - to a version that allows for as many rev-list
> operations to be accelerated as possible, and potentially immediate
> startup of full clone operations in the common case; ie skipping the
> "Counting Objects" and "Compressing Objects" phase once a matching
> index is found.
> 
> The plan will be to implement each step incrementally, with a test-*.c
> file along the way which tests the API provided by the revision cache
> API.  While the revision cache format will change along the way, this
> will not require an index format deprecation cycle, as integration with
> the rest of git will not happen until the format is settled.
> 
> The plan is to aim for one of these API milestones completed per week.
> When complete, each commit will contain tests for the level of cache
> that it delivers.  Later milestones include joining the dots -
> integrating with the 'rev-list' machinery and most importantly,
> 'pack-objects'.

I like this sharing not only completed code, but plans, designs (and
status reports) with Git Development Community (i.e. git mailing
list).  I like this very much.


I'd like to ask if there any results of profiling git server
(git-daemon) code: how much is spend on object enumeration this GSoC
project tries to make faster by the means of caching?

Are there prepared benchmarks and tests to check if the code gives
correct results, and to measure improvements brought by caching?
Would it be possible to get some real-life statistics of git-daemon
usage, so that you optimize against real scenarios?


I wish you good work on git-daemon caching...
-- 
Jakub Narebski
Poland
ShadeHawk on #git
