From: Krzysztof Mazur <krzysiek@podlesie.net>
Subject: Re: Failure to extra stable@vger.kernel.org addresses
Date: Tue, 20 Nov 2012 08:56:28 +0100
Message-ID: <20121120075628.GA7159@shrek.podlesie.net>
References: <20121119095747.GA13552@arwen.pp.htv.fi>
 <20121119151845.GA29678@shrek.podlesie.net>
 <7vk3thxuj2.fsf@alter.siamese.dyndns.org>
 <20121119225838.GA23412@shrek.podlesie.net>
 <CAMP44s0f0zYa1FVf9RhNuwYJbkQ7zPwgJ6=ty3c5knjo5a2TNw@mail.gmail.com>
 <7vlidxuowf.fsf@alter.siamese.dyndns.org>
 <20121120073100.GB7206@shrek.podlesie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Felipe Balbi <balbi@ti.com>, git@vger.kernel.org,
	Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 20 08:56:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TaihM-0001LK-5C
	for gcvg-git-2@plane.gmane.org; Tue, 20 Nov 2012 08:56:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752092Ab2KTH4f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2012 02:56:35 -0500
Received: from [93.179.225.50] ([93.179.225.50]:53806 "EHLO shrek.podlesie.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751613Ab2KTH4b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2012 02:56:31 -0500
Received: by shrek.podlesie.net (Postfix, from userid 603)
	id 06C694A0; Tue, 20 Nov 2012 08:56:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20121120073100.GB7206@shrek.podlesie.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210085>

On Tue, Nov 20, 2012 at 08:31:00AM +0100, Krzysztof Mazur wrote:
> On Mon, Nov 19, 2012 at 03:57:36PM -0800, Junio C Hamano wrote:
> > Felipe Contreras <felipe.contreras@gmail.com> writes:
> > 
> > > On Mon, Nov 19, 2012 at 11:58 PM, Krzysztof Mazur <krzysiek@podlesie.net> wrote:
> > >
> > >> --- a/git-send-email.perl
> > >> +++ b/git-send-email.perl
> > >> @@ -924,6 +924,10 @@ sub quote_subject {
> > >>  # use the simplest quoting being able to handle the recipient
> > >>  sub sanitize_address {
> > >>         my ($recipient) = @_;
> > >> +
> > >> +       # remove garbage after email address
> > >> +       $recipient =~ s/(.*>).*$/$1/;
> > >> +
> > >
> > > Looks fine, but I would do s/(.*?>)(.*)$/$1/, so that 'test
> > > <foo@bar.com> <#comment>' gets the second comment removed.
> > 
> > Yeah, but do you need to capture the second group?  IOW, like
> > "s/(.*?>).*$/$1/" perhaps?
> 
> I also thought about removing everything after first ">", but I will
> not work for addresses like:
> 
> Cc: "foo >" <stable@vger.kernel.org> #v3.4 v3.5 v3.6
> 
> What about:
> 
> 	$recipient =~ s/(.*<[^@]*@[^]]*>).*$/$1/;
> 
> or even
> 
> which uses regex used by 99% accurate version of extract_valid_address().
> 

Of course, as you suggested earier, only the first email address should
be used, so in both cases the first ".*" should be changed to ".*?".
The second version becomes:

diff --git a/git-send-email.perl b/git-send-email.perl
index 9840d0a..dbe520c 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -925,8 +925,11 @@ sub quote_subject {
 sub sanitize_address {
 	my ($recipient) = @_;
 
+	my $local_part_regexp = qr/[^<>"\s@]+/;
+	my $domain_regexp = qr/[^.<>"\s@]+(?:\.[^.<>"\s@]+)+/;
+
 	# remove garbage after email address
-	$recipient =~ s/(.*>).*$/$1/;
+	$recipient =~ s/^(.*?<$local_part_regexp\@$domain_regexp>).*/$1/;
 
 	my ($recipient_name, $recipient_addr) = ($recipient =~ /^(.*?)\s*(<.*)/);
 
Krzysiek
