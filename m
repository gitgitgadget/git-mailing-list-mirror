From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 2/2] ignorecase: Fix git mv on insensitive filesystems
Date: Wed, 07 May 2014 09:42:57 -0700
Organization: Twitter
Message-ID: <1399480977.11843.62.camel@stross>
References: <xmqqoazaelmi.fsf@gitster.dls.corp.google.com>
	 <1399417144-24864-1-git-send-email-dturner@twopensource.com>
	 <1399417144-24864-2-git-send-email-dturner@twopensource.com>
	 <5369CFDE.2070207@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com,
	David Turner <dturner@twitter.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed May 07 18:43:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi4w0-0006sV-Jz
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 18:43:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbaEGQnE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 12:43:04 -0400
Received: from mail-qc0-f175.google.com ([209.85.216.175]:45364 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932223AbaEGQnC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 12:43:02 -0400
Received: by mail-qc0-f175.google.com with SMTP id w7so1384019qcr.6
        for <git@vger.kernel.org>; Wed, 07 May 2014 09:43:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=g8rD0smgTEhVdXKXXMNs+w19QJNrFr2edo86ZgRzM+E=;
        b=cvV/8OV59GOkfRKnTp5uOgRd+fUorZGEbTUitd66u2rp4hn1WQDMo4NSvYatvqnd1h
         D0wO712QIbAZdC5IlaVp9yoendS4vv9FdXiFPZsxn57mBZgDYKNqU3wWVKPUkK8NyH5T
         y3L15mQ7QSqXPY18bbDAzV7drEs+tW5FM5ffRaiX+/AunAyG/KSlu6WojISdW5JXDnU2
         HUbKlD3qh/TPbD7kEX+GBmdXcmFyr30eoUkUdGDOeMjz+3dRcwOaJH6cqY/vBvXpjaBC
         TEFs8sK5UybyCSh2QbwvAo4fF2FTQfYJs8MDiJeKbDvfOzUZ7J+KTDkiqL6pj84MH2h0
         5Rgg==
X-Gm-Message-State: ALoCoQnnoPbvoTQsdu1fCgVNLdXqJaA8z/F5KUx10FMhULqvcHYEsB7u9ZKrKXa60HhhrmXc/ldA
X-Received: by 10.224.6.10 with SMTP id 10mr67880967qax.45.1399480981265;
        Wed, 07 May 2014 09:43:01 -0700 (PDT)
Received: from [172.25.144.67] ([8.25.197.27])
        by mx.google.com with ESMTPSA id n105sm20591261qgd.7.2014.05.07.09.42.59
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Wed, 07 May 2014 09:43:00 -0700 (PDT)
In-Reply-To: <5369CFDE.2070207@viscovery.net>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248330>

On Wed, 2014-05-07 at 08:17 +0200, Johannes Sixt wrote:
> >  		} else if (cache_name_pos(src, length) < 0)
> >  			bad = _("not under version control");
> > -		else if (lstat(dst, &st) == 0) {
> > +		else if (lstat(dst, &dst_st) == 0 &&
> > +			 (src_st.st_ino != dst_st.st_ino ||
> > +			  (src_st.st_ino == 0 && strcasecmp(src, dst)))) {
> 
> Don't do that. st_ino is zero on Windows only because we do not spend time
> to fill in the field. Don't use it as an indicator for a case-insensitive
> file system; zero may be a valid inode number on other systems.

I don't think it is a problem if zero is a valid inode.  The only thing
that happens when there is a zero inode, is that we have to compare
filenames.  The inode check is just an optimization to avoid doing a
bunch of strcasecmp on systems that don't have to.
