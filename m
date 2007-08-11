From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Advertise per branch RSS/Atom feeds
Date: Sat, 11 Aug 2007 21:57:31 +0200
Message-ID: <200708112157.31764.jnareb@gmail.com>
References: <7vps1ummqy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 12 00:06:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJz64-00053u-Ex
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 00:06:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762297AbXHKWGG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 18:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762329AbXHKWGF
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 18:06:05 -0400
Received: from fk-out-0910.google.com ([209.85.128.188]:37542 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762230AbXHKWGC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 18:06:02 -0400
Received: by fk-out-0910.google.com with SMTP id z23so1041033fkz
        for <git@vger.kernel.org>; Sat, 11 Aug 2007 15:06:00 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=F57sX7Kaab9fYQGj0xAM6L673e8TXxlz1oIw+eW7sAHc/FzSGnGGcW5GcFOaIUdoSKEIXbmleG716zymqdwFfnvYUfX22sM/eoO5T9lPG1NTquQSWRDvdvdOEjm80TJmBKt7W9h9SQUCnjUUfJukIL5r/XYjpe6kTl9Q+TSzJAM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=fa665r6IfMizZQWCA1sVenu9Q8z5g7k4mPkC+mfWzNBRPTADzULuLThLFjdaAEXFVh/LO1sRPNMC8at9PO8aFUrYB7xzem2sveVY4APe/thrFyOm80C6S5KTfR3WMXpUafuhw8+ysdVwuLpIlB4TU7zF7Sp7I+hZGsu9L0siDoc=
Received: by 10.86.3.2 with SMTP id 2mr3504150fgc.1186869960839;
        Sat, 11 Aug 2007 15:06:00 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id c28sm8331668fka.2007.08.11.15.05.57
        (version=SSLv3 cipher=OTHER);
        Sat, 11 Aug 2007 15:05:58 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vps1ummqy.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55640>

On Sat, 11 August 2007, Junio C Hamano wrote:

> The feeder code had provisions to accept 'h' parameter to
> specify which branch to send the feed data from, but there was
> no link that advertised this capability on the pages.
> 
> This adds h parameter to the footer of shortlog/log page for the
> branch.

And also of 'history' and 'tree' views; see comments below.

Besides, that is only half of the places where we put links to
RSS/Atom feeds. There are RSS/Atom feeds in the page header,
in the form of "<link .../>" elements; but that is perhaps for
separate patch. I think for example that we should add more
specialized feeds to HTML header instead of replacing generic
feeds by specialized ones like this patch does in footer.

>  	if (defined $project) {
>  		my $descr = git_get_project_description($project);
> +		my @tips = ();
> +		if ($hash !~ /^[0-9a-fA-F]{40}$/) {
> +			@tips = (hash => $hash);
> +		}

I'd use hash instead of array (list) here, c.f. %hash_base trick,
i.e. "my %tips" and "%tips = (hash => $hash);". Just for code
consistency and slightly better readibility.

By the way, the above would work also for 'history' and 'tree'
views if h parameter is not literal hash (perhaps we should exclude
"HEAD" as well, by the way), and we can have path limited feeds,
then perhaps it would be even better to use

			%tips = (hash=>$hash, file_name=>$file_name);

I'm also not sure if %tips (or @tips) is best name for this variable,
but I don't have better proposal. %narrow perhaps or something like
that.

>  		if (defined $descr) {
>  			print "<div class=\"page_footer_text\">" . esc_html($descr) . "</div>\n";
>  		}
> -		print $cgi->a({-href => href(action=>"rss"),
> +		print $cgi->a({-href => href(action=>"rss", @tips),
>  		              -class => "rss_logo"}, "RSS") . " ";
> -		print $cgi->a({-href => href(action=>"atom"),
> +		print $cgi->a({-href => href(action=>"atom", @tips),
>  		              -class => "rss_logo"}, "Atom") . "\n";
>  	} else {
>  		print $cgi->a({-href => href(project=>undef, action=>"opml"),
> 

And perhaps we should add title attribute explaining that feed is for
given branch... or perhaps not.

-- 
Jakub Narebski
Poland
