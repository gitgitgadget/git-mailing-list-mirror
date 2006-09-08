From: Jakub Narebski <jnareb@gmail.com>
Subject: gitweb: Add committags support
Date: Fri, 8 Sep 2006 12:46:56 +0200
Message-ID: <200609081246.56423.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Sep 08 12:46:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLdse-0008MC-1b
	for gcvg-git@gmane.org; Fri, 08 Sep 2006 12:46:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbWIHKqb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Sep 2006 06:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbWIHKqb
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Sep 2006 06:46:31 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:27062 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750786AbWIHKq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Sep 2006 06:46:29 -0400
Received: by nf-out-0910.google.com with SMTP id o25so634129nfa
        for <git@vger.kernel.org>; Fri, 08 Sep 2006 03:46:28 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=FJsJFRChOuDyzsvEzvWA5ODOpwu2x8C/l8TOABpGJig0hp4kwF72VBl6RMzYCmmg/vIExbJrBvKo73aQgr84uPCOf8pSSiD0uVh8tzu9t0LhcTXw6zfwqq4FJ3rkw/p6gCVFIsWUmCvKECxHhd4RgGnuoNksuIX5wZ6XTj/6dqo=
Received: by 10.49.8.1 with SMTP id l1mr3911489nfi;
        Fri, 08 Sep 2006 03:46:28 -0700 (PDT)
Received: from host-81-190-21-28.torun.mm.pl ( [81.190.21.28])
        by mx.gmail.com with ESMTP id z73sm5508734nfb.2006.09.08.03.46.27;
        Fri, 08 Sep 2006 03:46:27 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26695>

Below is very preliminary code (think early alpha) 
to add committags support (a la gitweb-xmms2) to gitweb.

One of the problems is having committags support 
in the subject/title line, which is hyperlink itself 
(with title and class attribute).

-- >8 --
our %committags = (
	'commitsha' => {
		'pattern' => qr/[0-9a-fA-F]{40}/,
		'sub' => sub {
			my $hash_text = shift;
			if (git_get_type($hash_text) eq "commit") {
				return
					$cgi->a({-href => href(action=>"commit", hash=>$hash_text),
					        -class => "text"}, $hash_text);
			}
			return undef;
		},
		'islink' => 1,
	},
	'mantis' => {
		'pattern' => qr/(BUG|FEATURE)\(\d+\)/,
		'options' => [ 'http://bugs.xmms2.xmms.se/view.php?id=' ],
		'sub' => sub {
			my $match = shift;
			my $URL = shift;
			my ($issue) = $match =~ /(\d+)/;
			return
				$cgi->a({-href => "$URL$issue"},
				        $match);
		},
		'islink' => 1,
	},
);

sub format_log_line_html_generic {
	my $line = shift;
	my $a_attr = shift;
	my @committags = @_;
	my %subst;

	$line = esc_html($line);
	$line =~ s/ /&nbsp;/g;
	
	for my $ctname (@committags) {
		next unless exists $committags{$ctname};
		my $wrap = ref($a_attr) eq "HASH" && %$a_attr &&
			$committags{$ctname}{'islink'};
		my @opts =
			exists $committags{$ctname}{'options'} ?
			@{$committags{$ctname}{'options'}} :
			();

		while ($line =~ m/($committags{$ctname}{'pattern'})/gc) {
			my $match = $1;
			my $repl = $committags{$ctname}{'sub'}->($match, @opts);
			next unless $repl;

			if ($wrap) {
				$repl = $cgi->end_a() . $repl . $cgi->start_a($a_attr);
			}

			$subst{quotemeta $match} = $repl;
		}
	}

	while (my ($from, $to) = each %subst) {
		$line =~ s/$from/$to/g;
	}
	return $line;
}



foreach my $line (@log) {
	print format_log_line_html_generic($line, undef, keys %committags) . "<br/>\n";
#	print format_log_line_html_generic($line, {-href=>"href", -title => "TITEL"}, keys %committags) . "<br/>\n";
}

-- 
Jakub Narebski
Poland
