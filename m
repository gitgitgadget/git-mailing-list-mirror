From: Marco Roeland <marco.roeland@xs4all.nl>
Subject: Re: [MinGW PATCH] Fixed error 'fatal: Not a git repository' on
	Vista
Date: Thu, 16 Aug 2007 11:56:55 +0200
Message-ID: <20070816095655.GA13069@fiberbit.xs4all.nl>
References: <DE6EEF3D318C4051827B95DF26D97BE7@ntdev.corp.microsoft.com> <46C40CB3.5415D888@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Thu Aug 16 12:06:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILcEK-0005HI-31
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 12:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759461AbXHPKFF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Aug 2007 06:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758968AbXHPKFF
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Aug 2007 06:05:05 -0400
Received: from smtp-vbr7.xs4all.nl ([194.109.24.27]:3880 "EHLO
	smtp-vbr7.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757481AbXHPKFC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2007 06:05:02 -0400
X-Greylist: delayed 467 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Aug 2007 06:05:01 EDT
Received: from fiberbit.xs4all.nl (fiberbit.xs4all.nl [213.84.224.214])
	by smtp-vbr7.xs4all.nl (8.13.8/8.13.8) with ESMTP id l7G9uuXw034642;
	Thu, 16 Aug 2007 11:56:56 +0200 (CEST)
	(envelope-from marco.roeland@xs4all.nl)
Received: from marco by fiberbit.xs4all.nl with local (Exim 4.67)
	(envelope-from <marco.roeland@xs4all.nl>)
	id 1ILc63-0003Pe-TK; Thu, 16 Aug 2007 11:56:55 +0200
Content-Disposition: inline
In-Reply-To: <46C40CB3.5415D888@eudaptics.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56000>

On Thursday August 16th 2007 at 10:37 Johannes Sixt wrote:

> I don't see how this could make a difference: __USE_MINGW_ACCESS appears
> in none of the mingw header files nor in the mingw.git sources.
> 
> Is my build environment outdated?

The mingw patch for fixing this Vista regression (from Danny Smith on
March 5th) is in mingw-runtime-3.12-1. It is in file <include/io.h> and
works like this:

#ifdef __USE_MINGW_ACCESS
/*  Old versions of MSVCRT access() just ignored X_OK, while the version
    shipped with Vista, returns an error code.  This will restore the
    old behaviour  */
static inline int __mingw_access (const char* __fname, int __mode)
  { return  _access (__fname, __mode & ~X_OK); }
#define access(__f,__m)  __mingw_access (__f, __m)
#endif

Whenever the X_OK bit is set in the mode flag for access(2) Vista
returns an error for the call. So yes, using __USE_MINGW_ACCESS will not
work on older mingw versions. Defining X_OK to 0 for mingw might fix the
problem for older versions.
-- 
Marco Roeland
