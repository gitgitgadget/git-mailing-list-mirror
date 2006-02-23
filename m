From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH] Convert open("-|") to qx{} calls
Date: 23 Feb 2006 08:07:34 -0800
Message-ID: <86hd6qgit5.fsf@blue.stonehenge.com>
References: <Pine.LNX.4.63.0602231532470.29635@wbgn013.biozentrum.uni-wuerzburg.de>
	<81b0412b0602230738s3445bd86h2d1d670e0ef5daed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Feb 23 17:07:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCJ0J-0007bZ-Tf
	for gcvg-git@gmane.org; Thu, 23 Feb 2006 17:07:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbWBWQHk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Feb 2006 11:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751564AbWBWQHk
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Feb 2006 11:07:40 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:33109 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1751533AbWBWQHj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2006 11:07:39 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id F025E8F767;
	Thu, 23 Feb 2006 08:07:34 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 19436-01-56; Thu, 23 Feb 2006 08:07:34 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 6364A8F768; Thu, 23 Feb 2006 08:07:34 -0800 (PST)
To: "Alex Riesen" <raa.lkml@gmail.com>
x-mayan-date: Long count = 12.19.13.1.7; tzolkin = 7 Manik; haab = 5 Kayab
In-Reply-To: <81b0412b0602230738s3445bd86h2d1d670e0ef5daed@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16653>

>>>>> "Alex" == Alex Riesen <raa.lkml@gmail.com> writes:

Alex> Is $tmpname safe?

>> -       my $sha = <$F>;
>> +       my $sha = qx{git-hash-object -w $name};
>> +       !$? or exit $?;

Alex> Is $name safe?

>> -       while(<$f>) {
>> +       foreach (qx{git-ls-tree -r -z $gitrev $srcpath}) {
>> chomp;

Alex> Is $srcpath safe?

>> -                       while(<$F>) {
>> +                       foreach (qx{git-ls-files -z @o1}) {

Alex> @o1 must contain filenames. Can be dangerous

Convert all of these to use "safe_qx" (perl 5.6 compatible):

    sub safe_qx {
      defined (my $pid = open my $kid, "-|") or die "Cannot fork: $!";
      unless ($pid) { # child does:
        exec @_;
        die "Cannot exec @_: $!";
      }
      my $result = do { local $/; <$kid> };
      close $kid;                   # sets $?
      return $result;
    }

my $result = safe_qx('some shell command');
my $other_result = safe_qx('git-ls-tree', '-r', '-z', $gitrev, $srcpath);

Args are safe, as if being passed to system/exec, so a single arg
can be a shell command, multiargs are passed arg-by-arg to a single
exec target.  $? is set correctly.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
