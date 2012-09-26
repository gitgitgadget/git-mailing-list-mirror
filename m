From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/7] Extract, test and enhance the logic to collapse
 ../foo paths.
Date: Wed, 26 Sep 2012 15:43:07 -0700
Message-ID: <20120926224307.GA31456@elie.Belkin>
References: <1343468312-72024-1-git-send-email-schwern@pobox.com>
 <1343468312-72024-4-git-send-email-schwern@pobox.com>
 <20120730195108.GA20137@dcvr.yhbt.net>
 <5016F2A5.1090102@pobox.com>
 <20120926194504.GA5013@elie.Belkin>
 <20120926205851.GA2166@dcvr.yhbt.net>
 <20120926213831.GB30131@elie.Belkin>
 <20120926215429.GA4637@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael G Schwern <schwern@pobox.com>, git@vger.kernel.org,
	gitster@pobox.com, robbat2@gentoo.org, bwalton@artsci.utoronto.ca
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Sep 27 00:43:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TH0KC-0006pU-BF
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 00:43:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753297Ab2IZWnP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2012 18:43:15 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:35389 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752997Ab2IZWnN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2012 18:43:13 -0400
Received: by pbbrr4 with SMTP id rr4so2590072pbb.19
        for <git@vger.kernel.org>; Wed, 26 Sep 2012 15:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=yysVVfzY9z6gE6zSOBcbDU69KMWxHthhlQNhT2XzHc0=;
        b=wQ7ylgV5ipqVriq01idoDEV++Zz/BgBPT3RnNZCJP9kHvrIJRLgzGaAuAx2n8hJ5IR
         1eL9o8Ja1Xr+FLq6C1qsLL60x+EP1lx3yivyz+mZBl7G1uTZyUTTFs08Kr9Oh+OnfAE5
         kAjjZQ3kAMtcXzDNmu6/J6u1wnl9CXUcQjEVkjMXXkdb/980Hwm4ipxKAozh9Mlo9k9X
         VdujQcu8qsrTBofLRdR5EGxOv8HOYVcMki1dWNoqB9GGWKxkIeQWEq7KVAwu14DGsIRQ
         SEP+Q2I/O52uVcSWHpTqGjJECzuIJyey84ksjllN5lZ92gplUleKaNoLc/ieuqw3ENH+
         R8XQ==
Received: by 10.68.129.98 with SMTP id nv2mr6275071pbb.85.1348699393584;
        Wed, 26 Sep 2012 15:43:13 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id pv9sm2706269pbb.67.2012.09.26.15.43.11
        (version=SSLv3 cipher=OTHER);
        Wed, 26 Sep 2012 15:43:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120926215429.GA4637@dcvr.yhbt.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206454>

Eric Wong wrote:

> It should probably just return the root path ("c:/" and
> "http://www.example.com/" respectively).

That means recognizing drive letters and URLs.  Hm.

Subversion commands seem to use svn_client_args_to_target_array2
to canonicalize arguments.  It does something like the following:

 1. split at @PEG revision
 2. check if it looks like a URL (svn_path_is_url).  If so:

    i.   urlencode characters with high bit set (svn_path_uri_from_iri)
    ii.  urlencode some other special characters (svn_path_uri_autoescape)
         (that is: [ "<>\\^`{|}])
    iii. (on Windows) convert backslashes to forward slashes
    iv.  complain if there are any '..' (svn_path_is_backpath_present)
    v.   make url scheme and hostname lowercase, strip default portnumber,
	 strip trailing '/', collapse '/'-es including urlencoded %2F,
	 strip '.' and '%2E' components, make drive letter in file:///
         URLs uppercase, urlencode uri-special characters
         (svn_uri_canonicalize)

   Otherwise:

    i.   canonicalize case, handle '..' and '.' components, and make
	 path separators into '/'
         (apr_filepath_merge(APR_FILEPATH_TRUENAME))
    ii.  strip trailing '/', collapse '/'-es except in UNC paths,
         strip '.' components, make drive letter uppercase
         (svn_dirent_canonicalize)
    iii. deal with "truepath collisions" (unwanted case
         canonicalizations)
    iv.  reject .svn and _svn directories

Maybe we can use apr_filepath_merge() to avoid reinventing the wheel?
