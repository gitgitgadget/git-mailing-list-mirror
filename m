From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Add treediff
Date: Mon, 26 Mar 2007 18:12:27 +0100
Message-ID: <200703261912.27612.jnareb@gmail.com>
References: <11748548622888-git-send-email-mkoegler@auto.tuwien.ac.at> <11748548621755-git-send-email-mkoegler@auto.tuwien.ac.at> <11748548623081-git-send-email-mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Mon Mar 26 19:11:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVsjC-0003rL-3X
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 19:11:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753032AbXCZRLT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 13:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753029AbXCZRLT
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 13:11:19 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:59437 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753031AbXCZRLR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 13:11:17 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1655026uga
        for <git@vger.kernel.org>; Mon, 26 Mar 2007 10:11:11 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=CpASkzd9I48RdPCJEHotjNIE/b9/aM0zx7Qege1uSbRVtNEMZ9932AZjGCAOiRmaDfcfWNFgEuQmd26KzYlRq7J6W7oFniL3WnCtsG2+ORJHkN8FxS3FCSc3+dFwCqn6lGLYeGQ9JBGAets5beZZCecA6fwGR/pA59J8bkdlrq8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=Gf9wNje6QbyibVDKUjgJv8rbPYZw51sQtoR+ImOHum4JkTNIgqklAjY7cRTCm0sHHeADjaPEs04pTSoRi0RL3BZn4sUFEgBcefN7Wgk9p9PMr3dVXTNlGKK5AF8TD6lVhEDVEue8XBSBefCCNs/WVpl5sBn7PBQ5pcLBiNhLmkA=
Received: by 10.78.138.14 with SMTP id l14mr3095335hud.1174929071381;
        Mon, 26 Mar 2007 10:11:11 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id e9sm22102910muf.2007.03.26.10.11.09;
        Mon, 26 Mar 2007 10:11:10 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <11748548623081-git-send-email-mkoegler@auto.tuwien.ac.at>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43164>

On Sun, Mar 25, 2007, Martin Koegler wrote:

> treediff supports comparing different trees. A tree can be specified
> either as hash or as base hash and filename.

I'd use "treediff" view, or git_treediff subroutine. Just a minor nit.
 
> +sub git_treediff {
> +	my $format = shift || 'html';
> +	my $from = $file_parent || "";
> +	my $to = $file_name || "";

I'd use  $file_name || '';  here, and of course

+	my $from = $file_parent || $file_name || '';

The unwritten rule is that we use 'fp' parameter (thet $file_parent
variable is set) only 

> +
> +	if (!defined $hash) {
> +		if (!defined $hash_base) {
> +			die_error('','tree parameter missing');

This conflicts with the coding style used elsewhere in the gitweb
(the informal coding convention / guideline for gitweb).

First, we either use  undef  and not  ''  to say: use default value
of the first parameter (HTTP status) of die_error, or provide our
own value in single quotes.

Second, the second parameter, error message, is a sentence (without
final fullstop) describing error; it means starting it with capital
letter. And we use double quotes for this parameter.

Examples:

	die_error(undef, "Couldn't find base commit");
	die_error(undef, "Unknown commit object");
	die_error(undef, "No file name defined");
	die_error(undef, "Open git-diff-tree failed");

	die_error('403 Permission denied', "Permission denied");
	die_error('404 Not Found', "File name not defined");
	die_error('404 Not Found', "Not enough information to find object");
	die_error('400 Bad Request', "Object is not a blob");

> +		}
> +		$hash = $hash_base;
> +		$hash .= ":".$file_name if (defined $file_name);
> +	}
> +
> +	if (!defined $hash_parent) {
> +		if (!defined $hash_parent_base) {
> +			die_error('','tree parameter missing');
> +		}
> +		$hash_parent = $hash_parent_base;
> +		$hash_parent .= ":".$file_parent if (defined $file_parent);

The same problem as above: we do not set 'fp' parameter (and $file_parent
variable) if name does not change. So you should use instead:

+		$hash_parent .= ":".($file_parent || $file_name)
+			if (defined $file_parent || defined $file_name);


Here I think (contrary to blobdiff case) it is better to use extended
SHA-1 syntax (taken from git-rev-parse(1)):

 * A suffix `:' followed by a path; this names the blob or tree at the given
   path in the tree-ish object named by the part before the colon.

> +	}
> +
> +	# we need to prepare $formats_nav before any parameter munging
> +	my $formats_nav;
> +	if ($format eq 'html') {
> +		$formats_nav =
> +			$cgi->a({-href => href(action=>"treediff_plain",
> +			                       hash=>$hash, hash_parent=>$hash_parent,
> +			                       hash_base=>$hash_base, hash_parent_base=>$hash_parent_base,
> +			                       file_name=>$file_name, file_parent=>$file_parent)},
> +			        "raw");


I certainly agree to that.

> +		if (defined $hash_parent_base && (my %co = parse_commit($hash_parent_base))) {
> +	 		$formats_nav .= " | from: ".
> +				$cgi->a({-href => href(action=>"commit",
> +			        	               hash=>$hash_parent_base)},
> +				        "commit")
> +				." | ".
> +				$cgi->a({-href => href(action=>"commitdiff",
> +				                       hash=>$hash_parent_base)},
> +				        "commitdiff")
> +				." | ".
> +				$cgi->a({-href => href(action=>"tree",
> +						       hash=>$co{'tree'},
> +				                       hash_base=>$hash_parent_base)},
> +				        "tree");
> +		}
> +	}

This depends if the similar change (feature) for "blobdiff" view
(in git_blobdiff subroutine) is accepted. Perhaps this could be
separated into separate patch?

> +
> +	# read treediff
> +	my $fd;
> +	my @difftree;
> +	if ($format eq 'html') {
> +		open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
> +			"--no-commit-id", "--patch-with-raw", "--full-index",
> +			$hash_parent, $hash, "--"
> +			or die_error(undef, "Open git-diff-tree failed");
> +
> +		while (my $line = <$fd>) {
> +			chomp $line;
> +			# empty line ends raw part of diff-tree output
> +			last unless $line;
> +			push @difftree, $line;
> +		}

This is also common with git_commitdiff. Should be it put into separate
subroutine? Or do this refactoring in another patch?

> +	} elsif ($format eq 'plain') {
> +		open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
> +			'-p', $hash_parent, $hash, "--"
> +			or die_error(undef, "Open git-diff-tree failed");

For "commitdiff_plain" view the email-like format, with commit message
and the patch is I think enough. The commit message serves as summary
for this view.

I think that it would be better for "treediff_plain" to have
whatchanged-like (with shothened sha1 for example) plain difftree
before the patchset.

> +	} else {
> +		die_error(undef, "Unknown treediff format");

And here you use standard convention to call die_error.

> +	}
> +
> +	# non-textual hash id's can be cached
> +	my $expires;
> +	if ($hash =~ m/^[0-9a-fA-F]{40}$/) {
> +		$expires = "+1d";
> +	}
> +
> +	# write header
> +	if ($format eq 'html') {
> +
> +		git_header_html(undef, $expires);
> +		if (defined $hash_base && (my %co = parse_commit($hash_base))) {
> +			git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
> +			git_print_header_div('commit', esc_html($co{'title'}), $hash_base);
> +			print "<div class=\"title\">$hash_base:$from vs $hash_parent_base:$to</div>\n";
> +		} else {
> +			print "<div class=\"page_nav\"><br/>$formats_nav<br/></div>\n";
> +			print "<div class=\"title\">$hash vs $hash_parent</div>\n";
> +		}
> +		print "<div class=\"page_body\">\n";

Usually we use title of the $hash_base ('hb') commit as a page header,
and I think we should do the same for "treediff" view. Only if it is not
possible we use "$hash vs $hash_parent" or equivalent. Do not cause
inconsistency, please. You can propose patch changing this, but make
it separate issue.

Additionally, "blob" view has page_path, and so has "blobdiff" view (it is
for $hash / $filename / $hash_base). And "tree" view has page_path, so
I think should "treediff" have; of course if $hash_base is defined.

> +
> +	} elsif ($format eq 'plain') {
> +		my $filename = basename($project) . "-diff.patch";
> +

In "commitdiff_plain" view we use

		my $filename = basename($project) . "-$hash.patch";

Perhaps we should use the same: "-diff.patch" does not make much sense.
Is it a typo?

[...]

Some of further code could also be shared between git_treediff and
git_commitdiff, but this could wait I guess for another separate patch.

-- 
Jakub Narebski
Poland
