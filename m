From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH RFC 08/10] send-email: Add --sleep for email throttling
Date: Sat, 11 Apr 2009 21:59:57 -0500
Message-ID: <f661ba4e-cfb0-4756-8ef4-4a4f9f66c4e8mfwitten@gmail.com>
References: <1239476908-25944-1-git-send-email-mfwitten@gmail.com>
	 <1239476908-25944-2-git-send-email-mfwitten@gmail.com>
	 <1239476908-25944-3-git-send-email-mfwitten@gmail.com>
	 <1239476908-25944-4-git-send-email-mfwitten@gmail.com>
	 <1239476908-25944-5-git-send-email-mfwitten@gmail.com>
	 <1239476908-25944-6-git-send-email-mfwitten@gmail.com>
	 <1239476908-25944-7-git-send-email-mfwitten@gmail.com>
	 <1239476908-25944-8-git-send-email-mfwitten@gmail.com>
	 <76718490904111927y683ee4axe512dae9d58e19bb@mail.gmail.com
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 12 05:21:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsqFt-00012R-EB
	for gcvg-git-2@gmane.org; Sun, 12 Apr 2009 05:21:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755429AbZDLDGo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Apr 2009 23:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755078AbZDLDGo
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 23:06:44 -0400
Received: from mail-gx0-f160.google.com ([209.85.217.160]:57263 "EHLO
	mail-gx0-f160.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754545AbZDLDGn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2009 23:06:43 -0400
Received: by gxk4 with SMTP id 4so3642716gxk.13
        for <git@vger.kernel.org>; Sat, 11 Apr 2009 20:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:date:subject
         :message-id:references;
        bh=ihAXZS4bV9c9hm95V1tlxdBbyUni92ncyyS3G/Qb6f8=;
        b=Nqa2H8OzdSRlbKKS6ZaDBINcnQafuHCI1jwwGuC68TlXHIeu3x/nG8J+J3jQazRwlk
         JE4s/fPiegEl2IA6qz6gvKzEDQN3RTXB7X1QjO56kZF7cDA1rbrLmUXtDdrVfD2gUlpb
         BFeqX6SZa7myyASC0P7xw8vjyRBJaHi8yJJCg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:date:subject:message-id:references;
        b=XXzCD2lDueavb/DZgqr3bz6EagtzaLBP+6Wp29OCh6ZIg4ybbB1uVFty6wMZgtToKK
         bHECfI9WUtGJT8sustM90MRGrJOC7Ws9wzpyLS2uZ6TEUm+LIP+8YKTlzFR1qIak5Ij2
         5dzNBOdl4dwI0dehg5KyHNsG50Ec3sXLoOxzw=
Received: by 10.150.133.13 with SMTP id g13mr9992576ybd.2.1239505601963;
        Sat, 11 Apr 2009 20:06:41 -0700 (PDT)
Received: from gmail.com (97-116-116-167.mpls.qwest.net [97.116.116.167])
        by mx.google.com with ESMTPS id 9sm6057283ywf.26.2009.04.11.20.06.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 11 Apr 2009 20:06:41 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116365>

On Sat, Apr 11, 2009 at 21:27, Jay Soffian <jaysoffian@gmail.com> wrote:
> On Sat, Apr 11, 2009 at 3:08 PM, Michael Witten <mfwitten@gmail.com> wrote:
>> +if (defined $sleep) {{
>> +}}
>
> What's the double-brackets about?

The {} that form the true-body of the if statement don't actually
denote a block. The extra layer of {} is explicitly creating a block.
This is done, because in Perl, blocks can be thought of as loops that
execute one iteration, so you can use all of the loop flow-control
operators 'redo', 'last', and 'next'.

In this case, I wanted to use 'last' to jump out of --sleep setup
should the user decide to do so, because I think it's cleaner than a
goto or variable check or superfluous loop:

if (defined $sleep) {{

	unless ($chain_reply_to) {
		...
		/^b/                                               or
		/^s/ and $chain_reply_to = 1                       or
		/^c/ and $sleep = undef, last                      or  # forget --sleep was ever used
		/^n/ and $chain_reply_to = 1, $sleep = undef, last or  # forget --sleep was ever used
		/^q/ and exit;
	}
	...
}}
# last jumps to here

Anyway, this particular behavior was requested (and seems reasonable):

	http://marc.info/?l=git&m=123929919621279&w=2

Sincerely,
Michael Witten
