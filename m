From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitweb: Support for snapshots in gitweb
Date: Thu, 17 Aug 2006 00:34:24 -0700
Message-ID: <7vhd0bu873.fsf@assigned-by-dhcp.cox.net>
References: <44E263DD.6030305@cam.ac.uk> <ebupuk$dgl$1@sea.gmane.org>
	<44E2F911.6060002@gmail.com> <7v4pwc4l0y.fsf@assigned-by-dhcp.cox.net>
	<44E40CB1.7040805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 17 09:34:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDcOb-00034b-TJ
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 09:34:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWHQHe1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 03:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbWHQHe1
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 03:34:27 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:19869 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932196AbWHQHe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Aug 2006 03:34:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060817073425.MKAP554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 17 Aug 2006 03:34:25 -0400
To: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
In-Reply-To: <44E40CB1.7040805@gmail.com> (Aneesh Kumar K. V.'s message of
	"Thu, 17 Aug 2006 11:59:05 +0530")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25553>

"Aneesh Kumar K.V" <aneesh.kumar@gmail.com> writes:

> @@ -2097,6 +2102,23 @@ sub git_tree {
>  	git_footer_html();
>  }
>  
> +sub git_snapshot {
> +	if (!defined $hash) {
> +		$hash = git_get_head_hash($project);
> +	}
> +	print $cgi->header(-type=>'application/x-tar', -Content-Encoding=>'x-gzip',
> +		'-content-disposition' => "inline; filename=\"$project.tar.gz\"",
> +		-status=> '200 OK');

These -Mixed-Case, '-sometimes-quoted', spaces sometimes around
double-arrow sometimes missing, parameters bother me.  Perhaps:

	print $cgi->header(-type => 'application/x-tar',
                           -content-encoding => 'x-gzip',
                           -content-disposition =>
                               "inline; filename=\"$project.tar.gz\"",
                           -status => '200 OK');

RFC 2616 says that "gzip" content-coding is registered with
IANA, so I do not think you need to say "x-gzip".

> +	open my $fd, "-|", "$GIT tar-tree $hash \'$project\' | gzip -c6" or die_error(undef, "Execute git-tar-tree failed.");

I think this "6" is because somebody suggested to use the
default "6" instead of "9" in your original and the suggestion
was because "9" tends to be too expensive.  

But if we do not have a good, specific, reason to use "6" (as
opposed to, say, "5" or "7") and have "6" here only because we
happen to know "6" is the current gzip default, then probably we
are better off just letting gzip decide what compression level
to use without specifying it ourselves?
