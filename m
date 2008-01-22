From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Let "git svn" run "git gc --auto" occasionally
Date: Mon, 21 Jan 2008 17:52:20 -0800
Message-ID: <7vtzl6vd7v.fsf@gitster.siamese.dyndns.org>
References: <20080119123557.GA30778@diana.vm.bytemark.co.uk>
	<20080119223249.8227.31460.stgit@yoghurt>
	<1200783050.5724.196.camel@brick> <20080120033737.GA7767@soma>
	<20080120093436.GA10924@diana.vm.bytemark.co.uk>
	<7vlk6k8fyp.fsf@gitster.siamese.dyndns.org>
	<20080121224818.GA8872@untitled>
	<7vr6gawvkt.fsf@gitster.siamese.dyndns.org>
	<20080122003911.GA16453@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>,
	Harvey Harrison <harvey.harrison@gmail.com>,
	git@vger.kernel.org, Kevin Ballard <kevin@sb.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Jan 22 02:53:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH8KC-0003ia-Kc
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 02:53:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753627AbYAVBwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 20:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752821AbYAVBwq
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 20:52:46 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44048 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752017AbYAVBwp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 20:52:45 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3387B63C7;
	Mon, 21 Jan 2008 20:52:43 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 89FBE63C6;
	Mon, 21 Jan 2008 20:52:37 -0500 (EST)
In-Reply-To: <20080122003911.GA16453@hand.yhbt.net> (Eric Wong's message of
	"Mon, 21 Jan 2008 16:39:11 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71397>

Eric Wong <normalperson@yhbt.net> writes:

>> >  sub init_vars {
>> > -	if (defined $_repack) {
>> > -		$_repack = 1000 if ($_repack <= 0);
>> > -		$_repack_nr = $_repack;
>> > -		$_repack_flags ||= '-d';
>> > -	}
>> > +	$_repack = 1000 unless (defined $_repack && $_repack > 0);
>> > +	$_repack_nr = $_repack;
>> > +	$_repack_flags ||= '-d';
>> >  }
>> >  
>> >  sub verify_remotes_sanity {
>> 
>> Thanks, but I think you need to do something about this part:
>> 
>> 2154:	if (defined $_repack && (--$_repack_nr == 0)) {
>> 
>> I'd say 
>> 
>> 	if ($_repack && (--$_repack_nr == 0)) {
>
> init_vars() is called unconditionally, and always defines $_repack.
> It could actually just be:
>
> 	if (--$_repack_nr == 0) {

But that means predecremented --$_repack_nr will count -1, -2, ...
until it wraps around when the user said "--repack=0", meaning
"never repack".  Instead you made it "do not repack for a many
many many rounds".

Which would be perfectly fine in practice but somehow feels a
bit dirty to me.
