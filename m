X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC] gitweb: Add committags support (take 2)
Date: Mon, 4 Dec 2006 00:01:12 +0100
Message-ID: <200612040001.13640.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Sun, 3 Dec 2006 23:01:23 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=SGYNMBd44mtyfL4dlUQp+Ja2/k93E4uJwiJ3PX0qpl3G8wE5qPiDoEKekrQ7bviAPg+kx90wXMNdS/ZR3/k3hzGezMSddDXPzz0y1F/jfaHz9LgiJYzR3Xib2SRrzCy56UJr2XH4SYYUJ7m2mUaG2Gc0jFbZMlqSWvLUUhyUReE=
User-Agent: KMail/1.9.3
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33150>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gr0Kl-0000AQ-Hf for gcvg-git@gmane.org; Mon, 04 Dec
 2006 00:01:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760151AbWLCXBR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006
 18:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760154AbWLCXBQ
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 18:01:16 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:49086 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1760151AbWLCXBP
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006
 18:01:15 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2846805uga for
 <git@vger.kernel.org>; Sun, 03 Dec 2006 15:01:14 -0800 (PST)
Received: by 10.67.97.7 with SMTP id z7mr10994189ugl.1165186873748; Sun, 03
 Dec 2006 15:01:13 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id b23sm12914058ugd.2006.12.03.15.01.12; Sun, 03 Dec
 2006 15:01:13 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

This is my second attemt at adding properly committags support, similar
to what gitweb-xmms2 added in e89abf232a83e579b2bbc76398aefa048661dddf.

In this attempt I follow Junio idea of sequential committags support,
marking some fragments as not-for-parsing for later committags nor
esc_html, instead of building the list of literal replacements to be
applied simultaneously.

The plan of patch series is the following:
 * [PATCH 1/3] gitweb: Add committags support
   (which would add generic committags support, reusing existing
    infrastructure of commit message line by line parsing and
    simplification: leave git_print_log as is, replacing only
    format_log_line_html by committags capable version)
 * [PATCH 2/3] gitweb: Abuse committags support
   (which would use committags for marking signoff lines, and for
    commit message simplification: compacting empty lines, removing
    initial and trailing empty lines)
 * [PATCH 3/3] gitweb: Use committags in subject line and tag comment
   (which would add committags support to subject line/title of commit,
    which is first line of commit message, and to tag message/comment)

But there are still some problems to be solved before posting proper
even the first patch; I'll discuss them part by part.

1. Should we provide examples of committags, even if they _have_ to have
be per project, or at least per gitweb instalation configuration, like
bugtracker support (depending on the bugtracker used by
project/projects) and message id support (depending on mailing list
archive project/projects use)? So far I have come with the following
committag examples (they are for [PATCH 1/3] in the series, so they
don't include signoff committag, not empty_lines_simplification
committag).

Should we use anonymous subroutines, or should we define one subroutine
per committag (how to name them: format_<name>_tag, or <name>_committag,
or committag_<name>,... ?) and reference it? The code below uses
anonymous subroutines.

The subroutine should return either reference to scalar which means
"do not process", scalar which means changed available for further
processing, or void (undef) which means no change. In [PATCH 2/3] we
will enable returning also list of elements, each of which could be
reference to scalar or scalar (for example signoff would return three
element list: opening span element as ref, signoff text as scalar,
closing span element as ref).

  our %committags = (
  	'sha1' => {
  		'pattern' => qr/[0-9a-fA-F]{40}/,
  		'sub' => sub {
  			my $hash_text = shift;
  			my $type = git_get_type($hash_text);
  			if ($type) {
  				return \$cgi->a({-href => href(action=>$type, hash=>$hash_text),
  				                -class => "text"}, $hash_text);
  			}
  			return undef;
  		},
  	},
  	'mantis' => {
  		'pattern' => qr/(BUG|FEATURE)\(\d+\)/,
  		'options' => [ 'http://bugs.xmms2.xmms.se/view.php?id=' ],
  		'sub' => sub {
  			my $match = shift;
  			my $URL = shift;
  			my ($issue) = $match =~ /(\d+)/;
  			return
  				\$cgi->a({-href => "$URL$issue"},
  				         $match);
  		},
  	},
  	'bugzilla' => {
  		'pattern' => qr/bug\s+\d+/,
  		'options' => [ 'http://bugzilla.kernel.org/show_bug.cgi?id=' ],
  		'sub' => sub {
  			my $match = shift;
  			my $URL = shift;
  			my ($bugno) = $match =~ /(\d+)/;
  			return
  				\$cgi->a({-href => "$URL=$bugno"},
  				         $match);
  		},
  	},
  	'URL' => {
  		'pattern' => qr!(http|ftp)s?://[a-zA-Z0-9%./]+[a-zA-Z0-9/]!,
  		'sub' => sub {
  			my $url = shift;
  			return
  				\$cgi->a({-href => $url},
  				         $url); # should be perhaps shortened
  		},
  	},
  	# this is committags v1 subroutine
  	'message_id' => { # use mailing list archive
  		'pattern' => qr!(message|msg)-id:?\s+<[^>]*>;!i,
  		'options' => [ 'http://news.gmane.org/find-root.php?message_id=' ],
  		'sub' => sub {
  			my $text = shift;
  			my $URL = shift;
  
  			$text =~ m/<([^>]*)>/;
  			my $msgid = $1;
  			my $link = $cgi->a({-href => "$URL<$msgid>"},
  			                   $msgid);
  			$text =~ s/$msgid/$link/;
  
  			return \$text;
  		},
  	},
  );

From those committags, only 'sha1' (used now in the limited commitsha
form currently in gitweb) and 'URL' are installation independent.
For xmms2 the 'mantis' tag is needed; for Linux kernel it would be nice
to have both 'bugzilla' and 'message_id' (with some LKML archive) used.

By the way, if you have ideas for other committags, please do write.
For example should esc_html be the last committag?


2. We might not want to use all defined committags in %committags hash.
We might want only some of them for commit message [body], some of them
for subject line, and some of them for tag message. Additionally the
_sequence_ of committags is important. As we cannot rely on 
"keys %committags" to be in any specific order, we have to provide
the ordering ourself. My idea is to use array with the hash keys
(the names of committags) to both define which committags are enabled,
and the sequence of committags itself.

In [PATCH 1/3] there is need for only one such array.

  our @committags = ('sha1');


3. To not split message into many fragments we concatenate strings
if possible. This happens when committag subroutine returns string
(for example we might want to hyperlink only bug number in 'bugzilla'
committag), or return undef (for example 'sha1' committag if the
there does not exist object with given hash, for example in the commit
message of commit cherrypicked from no longer existing branch).

This is example where Perl subroutine prototypes makes sense.

  # push_or_append ARRAY,LIST
  # if ARRAY ends with scalar, and LIST begins with scalar, concatenate
  sub push_or_append (\@@) {
  	my $list = shift;
  
  	if (ref $_[0] || ! @$list || ref $list->[-1]) {
  		push @$list, @_;
  	} else {
  		my $a = pop @$list;
  		my $b = shift @_;
  
  		push @$list, $a . $b, @_;
  	}
  	# imitate push
  	return scalar @$list;
  }


4. Here is the main subroutine for committags support, currently without
the extra parts which would allow committags in the subject line: the
subject is link (<a> element) itself, and in (X)HTML link elements cannot
be nested, so the encompassing <a> element has to be closed and reopened).

I have thought about three solutions, neither without disadvantages.
 * Mark committag as returning link in %committag hash, and wrap it in
   the format_log_line_html subroutine. Disadvantages: prone to config
   errors, doesn't work if link is only part of replacement.
 * Use special a_link subroutine in the committag subs instead of
   $cgi->a(). Disadvantages: need to pass attributes of encompassing
   <a> element to committag subroutine, prone to committag subroutine
   coding errors.
 * Wrap on dereferencing in the final output stage, checking if referenced
   string is wholly <a> element. Disadvantages: committags subroutine
   must return <a> elements separately.

Well, yet another solution would be to forbid committags support in the
subject/title line. gitweb-xmms2 tries to implement this, but not fully,
and not without errors.

  sub format_log_line_html {
	my $line = shift;
	my @committags = @_;

	my @list = ( $line );

   COMMITTAG:
  	foreach my $ctname (@committags) {
  		next COMMITTAG unless exists $committags{$ctname};
  
  		my @opts =
  			exists $committags{$ctname}{'options'} ?
  			@{$committags{$ctname}{'options'}} :
  			();
  		my @newlist = ();

  	PART:
  		foreach my $part (@list) {
  			next PART unless $part;
  			if (ref($part)) {
  				push @newlist, $part;
  				next PART;
  			}
  
  			my $oldpos = 0;
  		MATCH:
  			while ($part =~ m/($committags{$ctname}{'pattern'})/gc) {
  				my $match = $1;
  				my ($prepos, $postpos) = ($-[0], $+[0]);
  				my $repl = $committags{$ctname}{'sub'}->($match, @opts);
  
  				if (defined $repl) {
  					my $pre = substr($part, $oldpos, $prepos - $oldpos);
  
  					push_or_append @newlist, $pre if $pre;
  					push_or_append @newlist, $repl;
  				} else {
  					my $all = substr($part, $oldpos, $postpos - $oldpos);
  
  					push_or_append @newlist, $all if $all;
  				}
  
  				$oldpos = $postpos;
  			} # end while [regexp matches]
  
  			my $rest = substr($part, $oldpos);
  			push_or_append @newlist, $rest if $rest;
  
  		} # end foreach (@list)
  
  		@list = @newlist;
  	} # end foreach (@committags)
  
  	# print it
  	my $result = '';
  	for my $part (@list) {
  		if (ref($part)) {
  			$result .= $$part;
  		} else {
  			$result .= esc_html($part, -nbsp=>1);
 		}
  	}
  
  	return $result;
  }

-- 
Jakub Narebski
