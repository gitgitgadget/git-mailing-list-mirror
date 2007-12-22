From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Allow selection of different cleanup modes for commit
 messages
Date: Sat, 22 Dec 2007 11:18:34 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712221107240.21557@woody.linux-foundation.org>
References: <20071220211835.GA3052@steel.home> <alpine.LFD.0.9999.0712201324270.21557@woody.linux-foundation.org> <7vlk7plydv.fsf@gitster.siamese.dyndns.org> <alpine.LFD.0.9999.0712201555570.21557@woody.linux-foundation.org> <20071221173521.GA3494@steel.home>
 <7v8x3n4tbe.fsf@gitster.siamese.dyndns.org> <20071221230851.GA3260@steel.home> <7v3atv17o9.fsf@gitster.siamese.dyndns.org> <20071222184624.GA4167@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 22 20:19:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J69sP-0007p2-O4
	for gcvg-git-2@gmane.org; Sat, 22 Dec 2007 20:19:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752760AbXLVTSu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2007 14:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752389AbXLVTSt
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Dec 2007 14:18:49 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:49377 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752662AbXLVTSt (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Dec 2007 14:18:49 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBMJIZIs019562
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 22 Dec 2007 11:18:36 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBMJIY08016698;
	Sat, 22 Dec 2007 11:18:35 -0800
In-Reply-To: <20071222184624.GA4167@steel.home>
X-Spam-Status: No, hits=-4.112 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_71,J_CHICKENPOX_72,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69155>



On Sat, 22 Dec 2007, Alex Riesen wrote:
>
> +	if (!no_edit) {

This is unrelated to the rest of the patch, but I do think double 
negations are horrible, so I thoink we should probably make the "no_edit" 
flag change meaning, and call it "run_editor" or something.

That said, the thing that I'm actually reacting to is:

> +		if (in_merge)
> +			fprintf(fp,
> +				"#\n"
> +				"# It looks like you may be committing a MERGE.\n"
> +				"# If this is not correct, please remove the file\n"
> +				"#	%s\n"
> +				"# and try again.\n"
> +				"#\n",
> +				git_path("MERGE_HEAD"));
> +		if (cleanup_mode != CLEANUP_NONE)
> +			fprintf(fp,
> +				"\n"
> +				"# Please enter the commit message for your changes.\n");
> +		if (cleanup_mode == CLEANUP_ALL)
> +			fprintf(fp,
> +				"# (Comment lines starting with '#' will not be included)\n");
> +		if (only_include_assumed)
> +			fprintf(fp, "# %s\n", only_include_assumed);

The thing that still worries me about this set is that if you have 
"cleanup_mode == CLEANUP_NONE" or "cleanup_mode == CLEANUP_SPACE", we're 
now adding all these messages, and we depend on the user knowing that *he* 
has to remove them.

So I wonder if we should perhaps:

 (a) Only add these messages at all when we do *not* do CLEANUP_ALL

     In other words, change the

		if (!no_edit) {

     line to a

		if (cleanup_mode == CLEANUP_ALL && !no_edit) {

     instead, or

 (b) Add a a new line to replace he "will not be included" message, ie

		if (cleanup_mode != CLEANUP_ALL)
			fprintf(p,
				"# Please remove these comment lines manually,  "
				"they will not be automatically removed\n");

     or something similar.

I personally would prefer (a) - since anybody who then explicitly uses
--cleanup={space|none} would presumably already know what he is doing.

But this is not a huge deal. Regardless, the patch looks ok, so you can 
add a "Acked-by:" from me.

		Linus
