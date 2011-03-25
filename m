From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH svn-fe 0/4] vcs-svn: null bytes in properties
Date: Thu, 24 Mar 2011 22:34:31 -0500
Message-ID: <20110325033431.GA3007@elie>
References: <7vsjuegzj8.fsf@alter.siamese.dyndns.org>
 <1300970636-31743-1-git-send-email-david.barr@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 04:34:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2xnP-0002ro-7X
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 04:34:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934456Ab1CYDei (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2011 23:34:38 -0400
Received: from mail-gw0-f51.google.com ([74.125.83.51]:43741 "EHLO
	mail-gw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934428Ab1CYDeh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2011 23:34:37 -0400
Received: by gwj17 with SMTP id 17so53779gwj.10
        for <git@vger.kernel.org>; Thu, 24 Mar 2011 20:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=ulvSLXtaWn2zeZ2rAxw3ssXYVxnYyVt7x4rVjs8WVwc=;
        b=G5vGBgvcWx8zIR3OmDtzXCPL984+dmrXb4SCKU+1gG9a2F+2L4GeTgUpoIF1484sSZ
         jGt7bSTXvFEuMt5d9r/cHmCDlm6g6GIJjA+NGNMDWBrUubEHfLVWg7HVeNPJOisUwNlC
         OgQoD69vzYVW2wEtX4OwvrKyw65JkysqA6v1M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Yy+kiYktc3OpUiMfNOnKSQ49ndKWv0qU3ysmix7zm/9klWu9p+c8tEl9bu3CtMJGOx
         kLs1XQ69XxUDNphJp0XJXQiQgzfIaIdXwo/bkBfk1MhxiW+yNFYP60Mvx3rMvYqIDfpa
         ubw0GVZfnoby9o0J3H2eymdjsWdZgy+Si1Yhk=
Received: by 10.150.255.36 with SMTP id c36mr376456ybi.56.1301024076479;
        Thu, 24 Mar 2011 20:34:36 -0700 (PDT)
Received: from elie (adsl-68-255-102-141.dsl.chcgil.sbcglobal.net [68.255.102.141])
        by mx.google.com with ESMTPS id q29sm387944yba.17.2011.03.24.20.34.34
        (version=SSLv3 cipher=OTHER);
        Thu, 24 Mar 2011 20:34:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1300970636-31743-1-git-send-email-david.barr@cordelta.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169959>

David Barr wrote:

> it is permissible for both keys and values to contain
> nul characters.

You're right --- it's a regression to error out, though we never did
support it all that well.  How about this?

This doesn't take care of preserving embedded null bytes in the author
name.  That can come another day, I suppose.

Jonathan Nieder (4):
  vcs-svn: make reading of properties binary-safe
  vcs-svn: remove buffer_read_string
  vcs-svn: avoid unnecessary copying of log message and author
  vcs-svn: handle log message with embedded null bytes

 t/t0081-line-buffer.sh  |   35 ++++++----------
 t/t9010-svn-fe.sh       |  104 +++++++++++++++++++++++++++++++++++++++++++++++
 test-line-buffer.c      |    6 ---
 vcs-svn/fast_export.c   |   12 +++--
 vcs-svn/fast_export.h   |    9 ++--
 vcs-svn/line_buffer.c   |    8 ----
 vcs-svn/line_buffer.h   |    4 +-
 vcs-svn/line_buffer.txt |   12 +----
 vcs-svn/repo_tree.c     |    5 +-
 vcs-svn/repo_tree.h     |    4 +-
 vcs-svn/svndump.c       |   42 +++++++++----------
 11 files changed, 157 insertions(+), 84 deletions(-)
