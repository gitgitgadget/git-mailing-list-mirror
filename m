From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/5] gitweb: Option for filling only specified info in fill_project_list_info
Date: Fri, 10 Feb 2012 19:17:52 +0100
Message-ID: <201202101917.52908.jnareb@gmail.com>
References: <1328359648-29511-1-git-send-email-jnareb@gmail.com> <201202101456.45944.jnareb@gmail.com> <7v1uq2shwg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 19:18:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvv2t-0007cP-IR
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 19:18:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759568Ab2BJSSC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Feb 2012 13:18:02 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:49698 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757365Ab2BJSSB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 13:18:01 -0500
Received: by eekc14 with SMTP id c14so1051345eek.19
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 10:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=kzpTGHXBT4rWHTzViDibfaaVZvHbWbjW+0WUJ3STBH0=;
        b=hnR7OemRrfNst9Ne7IAe3f9BkPrpXgcqVD2vrVXqCSvwlLmxAKhvBXvOYbcgEfGscO
         p4HnNPS/NEJYSkNvj4hJibG/6yIx0f1CQHgDxfUpKPKgyoGLBAzxJ+mDGzgEa2tCRclt
         BmrORF2T/RCaNNA0c5gkpDiIdQ6qwzNTJ62zc=
Received: by 10.213.19.10 with SMTP id y10mr541305eba.72.1328897879932;
        Fri, 10 Feb 2012 10:17:59 -0800 (PST)
Received: from [192.168.1.13] (abwh187.neoplus.adsl.tpnet.pl. [83.8.231.187])
        by mx.google.com with ESMTPS id y12sm24709539eeb.11.2012.02.10.10.17.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Feb 2012 10:17:59 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7v1uq2shwg.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190431>

On Fri, 10 Feb 2012, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > (with either "..., 'owner', ..." or "..., [ 'owner' ], ..." for single-key
> > filling), or
> >
> >   if (project_info_needs_filled($pr, ['age', 'age_string'], \@fill_only) {
> >
> > Is it?
> 
> Whatever. I am not sure what @fill_only is needed for, if the name stands
> for "only fill these fields, if this argument is empty".  After all,
> doesn't the above example callsite, without ", \@fill_only" at the end,
> say "I am going to use age and age_string, so these two need to be filled"
> already?

No, the above example callsite says "Do I need to fill either 'age' or
'age_string'", and is followed by actually filling this info.

Currently the code flow WRT. project information goes like this:

  git_get_projects_list()
  # this fills some of project info; what is filled depends on whether
  # $projects_list is a file with list of project or directory to scan
  filter_forks_from_projects_list()
  # this does not use project info
  fill_project_list_info()
  # this fills all the rest of project info on reduced list
  search_projects_list(<search data>)
  # this uses some of project info

After 2/5 the code goes like this:

  git_get_projects_list()
  # this fills some of project info; what is filled depends on whether
  # $projects_list is a file with list of project or directory to scan
  filter_forks_from_projects_list()
  # this does not use project info
  fill_project_list_info(<search data>)
  # this fills the rest of project info required for search on reduced list
  search_projects_list(<search data>)
  # this uses some of project info
  fill_project_list_info()
  # this fills all the rest of project info on further reduced list

If @fill_only is empty, it means for fill_project_list_info to fill
all the data, if it is not empty it means that those fields needs to
be filled.

The code of fill_project_list_info goes like this

  if (do we need to fill 'age' or 'age_string'?) {
    fill 'age' and 'age_string'
  }
  if (do we need to fill 'desc_long' or 'descr'?) {
    fill 'descr_long' and 'descr'
  }
  if (we are interested in 'ctags' &&
      do we need to fill 'ctags'?) {
    fill 'ctags'
  }
  ...


-- 
Jakub Narebski
Poland
