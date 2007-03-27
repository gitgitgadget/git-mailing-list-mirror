From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Add treediff
Date: Tue, 27 Mar 2007 02:15:54 +0100
Message-ID: <200703270315.54901.jnareb@gmail.com>
References: <11748548622888-git-send-email-mkoegler@auto.tuwien.ac.at> <200703261912.27612.jnareb@gmail.com> <20070326210548.GD1128@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Tue Mar 27 03:12:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HW0F8-0000mH-JC
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 03:12:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933896AbXC0BMx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 21:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933901AbXC0BMx
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 21:12:53 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:4838 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933896AbXC0BMw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 21:12:52 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1758628uga
        for <git@vger.kernel.org>; Mon, 26 Mar 2007 18:12:51 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Y47YJ8JWGwoQNjtTymaXp4Au5cIaCelN7upebjSoanmUO2GZPn0Rm7Qxqb1MYGEkkmy2IZrJdMulXnVbVwoClmKqBHGqOwXDwTdJchdim2VgDCAdjo+iKA5x1deOiGAW9deHH1ywwvd+M4rKV4GmZ83tcOGQbcHyL7fP1AqFag8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=CYoVplxWCaavl1nZhnuQ0//53KZ9Ct84Pe0n80La9eboP7a8v5XW75a6JzEY0iC0mrRZsPZ2Sl9EHq0iV29/c/0zEjURTiScjrsHkaLx/9CXgT2wFB7DX4m2fbo/GFQwC0jHUIya/2MEGk6960e4sqqPd7/SsJPAkbv4SUpotFo=
Received: by 10.66.225.1 with SMTP id x1mr70272ugg.1174957971286;
        Mon, 26 Mar 2007 18:12:51 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id e8sm30338202muf.2007.03.26.18.12.48;
        Mon, 26 Mar 2007 18:12:49 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20070326210548.GD1128@auto.tuwien.ac.at>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43222>

Martin Koegler wrote:
> On Mon, Mar 26, 2007 at 06:12:27PM +0100, Jakub Narebski wrote:
>> On Sun, Mar 25, 2007, Martin Koegler wrote:

>>> +sub git_treediff {
>>> +	my $format = shift || 'html';
>>> +	my $from = $file_parent || "";
>>> +	my $to = $file_name || "";
>> 
>> I'd use  $file_name || '';  here, and of course
>> 
>> +	my $from = $file_parent || $file_name || '';
>> 
>> The unwritten rule is that we use 'fp' parameter (thet $file_parent
>> variable is set) only 
> 
> How do I specifiy the root tree (=tree in commit) with hpb/fp, as fp
> can not be empty, but only undefined?

As I said in previous message, we can simply relax check for 'f' and 'fp'
parameters, by changing

	!validate_pathname($file_name)

to

	!defined validate_pathname($file_name)
 
Still, there are some places where we assume that 'f' and 'fp' cannot be
empty, like in above proposal. It would be:

+	my $from = (defined $file_parent ? $file_parent : $file_name) || '';


Again, I don't want to loose the assumption that we generate 'fp' _only_
if it is different from 'f'. Otherwise old links would cease working,
which breaks backwards-compatibility, and is not cool. "Cool UR_is don't
change."

>>> +
>>> +	if (!defined $hash) {
>>> +		if (!defined $hash_base) {
>>> +			die_error('','tree parameter missing');
>> 
>> This conflicts with the coding style used elsewhere in the gitweb
[...]
>> Examples:
>> 	die_error(undef, "Couldn't find base commit");
[...]
> I didn't know this. I'll change this.

What's strange in other place you used die_error accoring to coding
guidelines.

>>> +
>>> +	} elsif ($format eq 'plain') {
>>> +		my $filename = basename($project) . "-diff.patch";
>>> +
>> 
>> In "commitdiff_plain" view we use
>> 
>> 		my $filename = basename($project) . "-$hash.patch";
>> 
>> Perhaps we should use the same: "-diff.patch" does not make much sense.
>> Is it a typo?
> 
> No. What unique name do you propose? It needs to include $hash and $hase_parent.
> In this case, $hash could be $hash_base:$file_name, I'm not sure, how to escape 
> $file_name.

For "commitdiff" case sole $hash is also not unique. But if not -hash,
then perhaps -treediff instead of simply -diff?

-- 
Jakub Narebski
Poland
