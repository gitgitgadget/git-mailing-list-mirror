From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-add--interactive: print message if there are no untracked files
Date: Wed, 21 Jan 2015 13:17:50 -0800
Message-ID: <xmqqegqnx281.fsf@gitster.dls.corp.google.com>
References: <1421867004-31672-1-git-send-email-kuleshovmail@gmail.com>
	<xmqqmw5bx2ii.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 22:17:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YE2ez-0007sg-HP
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 22:17:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753548AbbAUVRy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 16:17:54 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56176 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752449AbbAUVRw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 16:17:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 57D5A30B20;
	Wed, 21 Jan 2015 16:17:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7KNpd/LiQi84rbaovkOEKeB/uOY=; b=t8WWZD
	JDvc87rLyBsah0nKw4YJzdwjHtikXUTgt6H55jRw/yOVUtXamQgFiYQQKUsK2rXd
	ekxAkHPNMNxXwectnLn8XFD7lKNU9ZlMbz5AqwBR3p8R9dx2JQaKnXw8lesnLw6a
	A7G8wqQ2md6q0Hxn8ZYcbiiTUF40imt8WD35E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yft1LM5M8TBjTZZtuJ71v6AmYyfl9ucz
	Z0hzPGnoogr4M+K+rHZGKyiCaMUO5ZpnVjXjH1hTZ9q12WSQrI0LapuQtj/k7S/e
	6yzhptz+4RecJCal93X1d0AdcFOO1U4OiFrykPUA4/sSMPFGLRZNEMxnPUqtHjpk
	ACitxwT8M8Q=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4DD0130B1F;
	Wed, 21 Jan 2015 16:17:52 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C935430B1C;
	Wed, 21 Jan 2015 16:17:51 -0500 (EST)
In-Reply-To: <xmqqmw5bx2ii.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 21 Jan 2015 13:11:33 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F538B96A-A1B2-11E4-87F8-D3749F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262770>

Junio C Hamano <gitster@pobox.com> writes:

>>  sub add_untracked_cmd {
>> -	my @add = list_and_choose({ PROMPT => 'Add untracked' },
>> -				  list_untracked());
>> -	if (@add) {
>> -		system(qw(git update-index --add --), @add);
>> -		say_n_paths('added', @add);
>> +	if (system(qw(git ls-files --others --exclude-standard --))) {
>
> But this ls-files invocation that knows too much about how
> list_untracked() computes things does not.
>
> Why not
> ...
> or something instead?

Actually, is there any case where list_and_choose() should give a
prompt to choose from zero candidates?

In other words, I am wondering if this affects other callers of
list_and_choose in any negative way.

 git-add--interactive.perl | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 94b988c..46ed9a7 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -519,6 +519,10 @@ sub error_msg {
 sub list_and_choose {
 	my ($opts, @stuff) = @_;
 	my (@chosen, @return);
+
+	if (!@stuff) {
+		return @return;
+	}
 	my $i;
 	my @prefixes = find_unique_prefixes(@stuff) unless $opts->{LIST_ONLY};
 
