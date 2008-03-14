From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [PATCH] gitweb: Support caching projects list
Date: Thu, 13 Mar 2008 20:07:09 -0400
Message-ID: <76718490803131707g34fd40d4q21c69391c2597bc@mail.gmail.com>
References: <20080313231413.27966.3383.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Mar 14 01:07:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZxSi-000396-Ve
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 01:07:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743AbYCNAHN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 20:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754568AbYCNAHM
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 20:07:12 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:58141 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631AbYCNAHL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 20:07:11 -0400
Received: by wx-out-0506.google.com with SMTP id h31so3992852wxd.4
        for <git@vger.kernel.org>; Thu, 13 Mar 2008 17:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=9qqIfvGbLBLd1WRYCBPZZCclyj8Defi/+lBailKdm4Q=;
        b=oqcTOmLUzdaJYVudgT5S40Zm928aey+xOShSgSxXuppxulrgXRa+oGpTjXCJUbeooE766uC1aM4D9lZ8IlyCkel9REcy8PZKvEMCWUWqGFG1dGZT/ToUVxloCk6lhJVcAleeRcm5ekpPinBtBSvPfapoFKbThER9YG/Da8hFRFI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=j5rlh+vcLHAVKAXMOm9me8mEMgNc1MK8lY1JBfAMUvixRHrpBnJR9WmipZfEy0w9P65mboeEfDa5WNuBRVKTmUXvob1uUrJGjf8H8XMDSWJZnCnYdru4cqjWnHkDIwVsYb2VJSZ4fTa74ktY5KI2qMaGzwuOLjE4p1E8lYCViCM=
Received: by 10.141.22.1 with SMTP id z1mr6179055rvi.282.1205453229598;
        Thu, 13 Mar 2008 17:07:09 -0700 (PDT)
Received: by 10.141.29.7 with HTTP; Thu, 13 Mar 2008 17:07:09 -0700 (PDT)
In-Reply-To: <20080313231413.27966.3383.stgit@rover>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77152>

On Thu, Mar 13, 2008 at 7:14 PM, Petr Baudis <pasky@suse.cz> wrote:
>  diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
>  index 8e2bf3d..673077a 100644
>  --- a/gitweb/gitweb.css
>  +++ b/gitweb/gitweb.css
>  @@ -85,6 +85,12 @@ div.title, a.title {
>         color: #000000;
>   }
>
>  +div.stale_info {
>  +       display: block;
>  +       text-align: right;
>  +       font-style: italic;
>  +}
>  +
>   div.readme {
>         padding: 8px;
>   }

What does this have to do with it?

>  diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>  index bcb6193..0eee195 100755
>  --- a/gitweb/gitweb.perl
>  +++ b/gitweb/gitweb.perl
>  @@ -122,6 +122,15 @@ our $fallback_encoding = 'latin1';

...

>  +               if ($cache_lifetime and -f $cache_file) {
>  +                       # Postpone timeout by two minutes so that we get
>  +                       # enough time to do our job.
>  +                       my $time = time() - $cache_lifetime + 120;
>  +                       utime $time, $time, $cache_file;
>  +               }

Race condition. I don't see any locking. Nothing keeps multiple instances from
regenerating the cache concurrently...

>  +               @projects = git_get_projects_details($projlist, $check_forks);
>  +               if ($cache_lifetime and open (my $fd, '>'.$cache_file)) {

...and then clobbering each other here. You have two choices:

1) Use a lock file for the critical section.

2) Assume the race condition is rare enough, but you still need to account for
it. In that case, you want to write to a temporary file and then rename to the
cache file name. The rename is atomic, so though N instances of gitweb may
regenerate the cache (at some CPU/IO overhead), at least the cache file won't
get corrupted.

Out of curiosity, repo.or.cz isn't running this as a CGI is it? If so, wouldn't
running it as a FastCGI or modperl be a vast improvement?

j.
