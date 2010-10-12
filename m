From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 7/7] svn-fe: Use the --report-fd feature
Date: Tue, 12 Oct 2010 18:03:44 -0500
Message-ID: <20101012230344.GH15587@burratino>
References: <1286891424-2067-1-git-send-email-david.barr@cordelta.com>
 <1286891424-2067-8-git-send-email-david.barr@cordelta.com>
 <AANLkTikxsP_DV2Tjwk9vNi1WZFFiFEjQjCjhcbc5FETf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 01:07:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5nw8-0000xI-K4
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 01:07:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751606Ab0JLXHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 19:07:06 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:50877 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347Ab0JLXHF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Oct 2010 19:07:05 -0400
Received: by gxk6 with SMTP id 6so712217gxk.19
        for <git@vger.kernel.org>; Tue, 12 Oct 2010 16:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=2O3Q8gItMdCfGBKGAGfLoqEYMVcXrzNWH2LlMvfzz1A=;
        b=S/kxJ9t+ENupmx6PPimcFQi5Ti/A4eJmCSobG13xtDQIutwKE2uZlLfqhD4eFBUHgQ
         H6tHaD+2S1XdVemuxuCjAwqa7aJ0j5nGEgNrvtCJfE3BXSoOuqF+X8fwBcALid12OHZx
         6v1hAxARblFCgJLZNTs/y+i0J3b4T5A88SDzE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=wIUqfbmOkqWp+wEPW0Szk8GcggdMmsMMW60v61El+xh3I0995f4JpULwsss7o3aNNV
         H0+vcCPg2sawCgDoljXdttynq9zMhSXK5qvVxdc5UvNUhsZoCEeQGa4jgc7NPimJyQho
         2bGQ0F3W1pFdgC+ze4R1opQ+ai9wACrSnctyU=
Received: by 10.100.42.9 with SMTP id p9mr4154343anp.95.1286924823926;
        Tue, 12 Oct 2010 16:07:03 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id c32sm11164254anc.1.2010.10.12.16.07.02
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 12 Oct 2010 16:07:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikxsP_DV2Tjwk9vNi1WZFFiFEjQjCjhcbc5FETf@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158894>

Sverre Rabbelier wrote:
> On Tue, Oct 12, 2010 at 15:50, David Barr <david.barr@cordelta.com> wrote:

>> On one hand, this makes the interface much uglier.
>
> Can you quantify this? What does it make uglier, and why?

| -svnadmin dump --incremental REPO | svn-fe [url] | git fast-import
| +mkfifo backchannel &&
| +svnadmin dump --incremental REPO |
| +	svn-fe [url] 3<backchannel |
| +	git fast-import --report-fd=3 3>backchannel

The caller has to take care of backflow of data.  Even if the
"cat" command were never used, at least 3>/dev/null would be
necessary to avoid fast-import waiting forever for the frontend
to read from it.

One way to work around this would be for svn-fe to launch fast-import
itself.  The main downside is that that would require a way to
configure how fast-import is to be launched (for use with other
vcs-fast-import backends and in even stranger scenarios).
