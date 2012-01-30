From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v5 2/5] gitweb: add project_filter to limit project list to a subdirectory
Date: Mon, 30 Jan 2012 16:57:12 +0100
Message-ID: <201201301657.12944.jnareb@gmail.com>
References: <20120128165606.GA6770@server.brlink.eu> <20120130095252.GA6183@server.brlink.eu> <20120130114557.GB9267@server.brlink.eu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Bernhard R. Link" <brl+git@mail.brlink.eu>
X-From: git-owner@vger.kernel.org Mon Jan 30 16:56:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rrtb3-0007TG-Bp
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 16:56:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753465Ab2A3P4l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 10:56:41 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:37807 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753196Ab2A3P4k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 10:56:40 -0500
Received: by eekc14 with SMTP id c14so1481001eek.19
        for <git@vger.kernel.org>; Mon, 30 Jan 2012 07:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=l9f6UpkoHhov7GWReJ8EJMqZd9SAE8mrH6R4WkJXHpM=;
        b=RsWnRhToiDhnTSheR3LrrjTufYK+aK+OVut4dEjNPp19ETrQIQR3HVoKfVRL0wm7Ch
         fUslHwV/GI8Zc+smyNkO9a8MPH1VcoJb6qb0O5DQqXQEtFrpF1Z7r+WRlfXTjHi9gd/9
         8CtL7smTPJeBswT1HmvD5mPxGJRo+yb938GBk=
Received: by 10.14.200.196 with SMTP id z44mr1284258een.116.1327938999349;
        Mon, 30 Jan 2012 07:56:39 -0800 (PST)
Received: from [192.168.1.13] (abwi152.neoplus.adsl.tpnet.pl. [83.8.232.152])
        by mx.google.com with ESMTPS id n56sm74047054eeh.6.2012.01.30.07.56.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 30 Jan 2012 07:56:38 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20120130114557.GB9267@server.brlink.eu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189369>

On Mon, 30 Jan 2012, Bernhard R. Link wrote:

> This commit changes the project listing views (project_list,
> project_index and opml) to limit the output to only projects in a
> subdirectory if the new optional parameter ?pf=directory name is
> used.

It would be nice to have in this or in a separate commit an update
to get_page_title() for HTML output, and to git_opml() updating
<title> element in OPML output, so that it mentions that project
list is limitied to $project_filter subdirectory.

For plain text output of git_project_index() nothing really can be
done -- there is no title.  Well, we could fiddle with 'filename'
part of Content-Disposition HTTP header...
 
> The implementation of the filter reuses the implementation used for
> the 'forks' action (i.e. listing all projects within that directory
> from the projects list file (GITWEB_LIST) or only projects in the
> given subdirectory of the project root directory without a projects
> list file).

O.K., more detailed description of $strict_export interaction is in
that other commit.

> Reusing $project instead of adding a new parameter would have been
> nicer from a UI point-of-view (including PATH_INFO support) but
> would complicate the $project validating code that is currently
> being used to ensure nothing is exported that should not be viewable.

Nb. I wonder if we should make it invalid to have both 'project' and
'project_filter' parameters...
 
> @@ -994,6 +995,13 @@ sub evaluate_and_validate_params {
>  		}
>  	}
>  
> +	our $project_filter = $input_params{'project_filter'};
> +	if (defined $project_filter) {
> +		if (!validate_pathname($project_filter)) {
> +			die_error(404, "Invalid project_filter parameter");
> +		}
> +	}
> +

That accidentally makes "pf=foo/" (with trailing slash) invalid.
On the other hand being able to assume that $project_filter doesn't
end in '/' simplifies code a bit.

> @@ -5984,7 +5992,7 @@ sub git_project_list {
> -	my @list = git_get_projects_list();
> +	my @list = git_get_projects_list($project_filter, $strict_export);

>  sub git_project_index {
> -	my @projects = git_get_projects_list();
> +	my @projects = git_get_projects_list($project_filter, $strict_export);

>  sub git_opml {
> -	my @list = git_get_projects_list();
> +	my @list = git_get_projects_list($project_filter, $strict_export);

Nice!

-- 
Jakub Narebski
Poland
