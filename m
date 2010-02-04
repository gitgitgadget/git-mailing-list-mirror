From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/4] gitweb: notes feature
Date: Thu, 4 Feb 2010 18:21:21 +0100
Message-ID: <201002041821.22864.jnareb@gmail.com>
References: <1265300338-25021-1-git-send-email-giuseppe.bilotta@gmail.com> <7vpr4lhsfu.fsf@alter.siamese.dyndns.org> <7v4olxhrti.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 18:25:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nd5S2-0002OD-6q
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 18:25:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933291Ab0BDRXu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 12:23:50 -0500
Received: from gv-out-0910.google.com ([216.239.58.185]:37213 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933482Ab0BDRXp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 12:23:45 -0500
Received: by gv-out-0910.google.com with SMTP id c17so7728gvd.37
        for <git@vger.kernel.org>; Thu, 04 Feb 2010 09:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=8TV0xtMFsrzrdaetz2ediZB+oxpsjqkg0BJrhEHdzDA=;
        b=utGVnugauGZfP6hw4WHFrBFLKYfRVHFKyWdh/z+gL0MCX1EqdViVr/du/fG2QeF9I3
         hWQiGNayAz6rI52g3YIf7jj6H3qgMDBak5QZelW2naBC5oL5egf7dU4qscu/uSGj+Zjb
         weacgtvlQIU7iC+REXWVW+a344yDrOH2uNkQs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=oGZqx+VVXp9s2CFA3RfODWGpXozXxwAEORTxLlOv+ikWrfebizZUkP7SFUzEMmKN9O
         e9EK+FH02s8FTRiEXHxYz1wRkQSmhZXZTVMj8Orn+CqCj/uHlfRn1bFwrDDqIo8G+VnZ
         aUoTbEUt3tNCkcCpIZPNNFKW5qtZIxACLmDa0=
Received: by 10.103.48.38 with SMTP id a38mr884095muk.37.1265303898430;
        Thu, 04 Feb 2010 09:18:18 -0800 (PST)
Received: from ?192.168.1.13? (abrz208.neoplus.adsl.tpnet.pl [83.8.119.208])
        by mx.google.com with ESMTPS id s10sm1976421muh.59.2010.02.04.09.18.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Feb 2010 09:18:16 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7v4olxhrti.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138986>

On Thu, 4 Feb 2010, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>>
>>> +		my %notes = () ;
>>> +		foreach my $note_ref (@note_refs) {
>>> +			my $obj = "$note_ref:$co{'id'}";
>>
>> I think this look-up is wrong (meaning: will stop working anytime in the
>> future, and needs to be rewritten).
> 
> IOW, the code should be reading output from:
> 
>     GIT_NOTES_REF=$note_ref git show -s --format=%N $co{'id'}
> 
> as the notes tree may not be storing notes in a flat one-level namespace
> like you are assuming.

First, for some mechanism of deployment (IIRC Apache's mod_perl) changes
to environment variables from CGI script are not passed to invoked
commands (I guess for security reasons).  That is why gitweb uses --git-dir
parameter to git wrapper, and not GIT_DIR environment variable since
25691fb (gitweb: Use --git-dir parameter instead of setting $ENV{'GIT_DIR'},
2006-08-28).  So for proper support we would need --notes-ref (or similar)
option to git wrapper

  git --notes-ref=$note_ref show -s --format=%N $co{'id'}


Second, parse_commit / parse_commits use

  git rev-list -z --parents --header --max-count-X

If this command automatically shows notes (or it can be modified to
automatically show notes) after unindented "Notes:" line (as per
git-notes documentation), then the only thing that needs to be
changed to fill %commit{'notes'} is parse_commit_text subroutine.

There would be no need for extra subroutine (and extra command, or
even up to two extra commands per note) to get notes data.

-- 
Jakub Narebski
Poland
