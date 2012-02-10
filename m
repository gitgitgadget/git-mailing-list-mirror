From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/5] gitweb: Option for filling only specified info in fill_project_list_info
Date: Fri, 10 Feb 2012 22:30:12 +0100
Message-ID: <201202102230.13193.jnareb@gmail.com>
References: <1328359648-29511-1-git-send-email-jnareb@gmail.com> <201202101917.52908.jnareb@gmail.com> <7vsjiipiyu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 22:30:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvy2v-0005hH-Fv
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 22:30:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758548Ab2BJVaP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Feb 2012 16:30:15 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:64061 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236Ab2BJVaO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 16:30:14 -0500
Received: by eekc14 with SMTP id c14so1098511eek.19
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 13:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=wHNw41OPYqdXsb2G7tU3TbycAuM5SOSlitxrfYUROlo=;
        b=PK1/PbCTXJVZqz2GDD3OKxBDVdUXtSep6rhKarE+hIP2qVq8XQTC7wX/UimmT+KCg3
         5FjTFhczhEDygPs/WED2HyKaNyTb/6/0peUzAykiTco/fbhEnm4rVrQtXMwGI5G/eZNU
         9FrHbHYBbyM88Kgp+oFAJ24hUB4pBN3A2wwJI=
Received: by 10.14.48.66 with SMTP id u42mr2542720eeb.59.1328909413164;
        Fri, 10 Feb 2012 13:30:13 -0800 (PST)
Received: from [192.168.1.13] (abwh187.neoplus.adsl.tpnet.pl. [83.8.231.187])
        by mx.google.com with ESMTPS id o49sm26676836eeb.7.2012.02.10.13.30.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Feb 2012 13:30:12 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vsjiipiyu.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190459>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > If @fill_only is empty, it means for fill_project_list_info to fill
> > all the data, if it is not empty it means that those fields needs to
> > be filled.
> 
> That is exactly what I am questioning.  Do you need "I need all these
> fields to be present" and "I will fill these other fields" (which is what
> @fill_only is about, no?) that is different from the former?

"I need all these fields" is a property of callsite.  fill_project_list_info()
will be called more than one time in 2/5 to incrementally complete project
info, see below.
 
"I will fill those fields" is a property of piece of code protected by
a conditional inside fill_project_list_info().

> > The code of fill_project_list_info goes like this
> >
> >   if (do we need to fill 'age' or 'age_string'?) {
> >     fill 'age' and 'age_string'
> >   }
> >   if (do we need to fill 'desc_long' or 'descr'?) {
> >     fill 'descr_long' and 'descr'
> >   }
> >   if (we are interested in 'ctags' &&
> >       do we need to fill 'ctags'?) {
> >     fill 'ctags'
> >   }
> >   ...
> 
> Exactly.  Why do you need @fill_only at all?  If you are interested in
> ctags and you want to make sure ctags is available, the question you want
> to ask the helper function is "Does the project structure already have
> ctags field?".  Why does the helper function needs to know anything else?

It is to support incremental filling of project info.  The code is to
go like this:

  create
  filter
  fill part
  filter
  fill rest

We need @fill_only for the "fill part".  As filling project info is
potentially expensive (especially the 'age' field), doing it on narrowed
(filtered) list of project is a performance win.  That is what 2/5 is
about.

-- 
Jakub Narebski
Poland
