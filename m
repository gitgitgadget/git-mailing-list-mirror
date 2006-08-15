From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/9] gitweb: Separate ref parsing in git_get_refs_list into parse_ref
Date: Mon, 14 Aug 2006 17:29:24 -0700
Message-ID: <7vu04ec04b.fsf@assigned-by-dhcp.cox.net>
References: <200608140202.46160.jnareb@gmail.com>
	<200608140207.01108.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 15 02:29:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCmoD-0001WP-GV
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 02:29:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbWHOA30 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 20:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752003AbWHOA30
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 20:29:26 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:19088 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751460AbWHOA3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 20:29:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060815002925.TPZI29796.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 14 Aug 2006 20:29:25 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200608140207.01108.jnareb@gmail.com> (Jakub Narebski's message
	of "Mon, 14 Aug 2006 02:07:00 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25427>

Jakub Narebski <jnareb@gmail.com> writes:

> Note that for each ref there are usually two calls to git subroutines:
> first to get the type of ref, second to parse ref if ref is of commit
> or tag type.
>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
>  gitweb/gitweb.perl |   80 +++++++++++++++++++++++++++++-----------------------
>  1 files changed, 45 insertions(+), 35 deletions(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 28df59e..0c4ec92 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -690,6 +690,49 @@ sub parse_commit {
>  	return %co;
>  }
>  
> +# parse ref from ref_file, given by ref_id, with given type
> +sub parse_ref {
> +	my $ref_file = shift;
> +	my $ref_id = shift;
> +	my $type = shift || git_get_type($ref_id);

This git_get_type() is additional from the original.
Future-proofing yourself for other new callers?
