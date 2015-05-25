From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/1] send-email: Add sendmail email aliases format
Date: Mon, 25 May 2015 09:32:23 -0700
Message-ID: <xmqqpp5obotk.fsf@gitster.dls.corp.google.com>
References: <49e9a95b52aa61ed4f37edf1dfa178186acb4a29.1432367540.git.allenbh@gmail.com>
	<xmqqfv6nchmf.fsf@gitster.dls.corp.google.com>
	<xmqq382ncgmb.fsf@gitster.dls.corp.google.com>
	<CAJ80savVjb3_iKhNWPjQNK72DL7eq5YkbjWWG-1Gkx5+LOjzeg@mail.gmail.com>
	<CAJ80sas_D-6z4MvuFvvjoX7U_bM6b3brCo4rvYFCUfTmKS=6bA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Allen Hubbe <allenbh@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 25 18:32:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwvIk-0006k1-Aa
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 18:32:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbbEYQc0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 12:32:26 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:34123 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914AbbEYQcZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2015 12:32:25 -0400
Received: by ieczm2 with SMTP id zm2so75489285iec.1
        for <git@vger.kernel.org>; Mon, 25 May 2015 09:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=tnL8ImzWny8WcDiwyRj5C1MXTP5Qrsqn08SiCWBdYc0=;
        b=zSkknXxBfcz/wkuariC/mzNl9ixFleLGB+XBY+ui0lrKDQbzI0q4wVw0PJIdQrlVnB
         xoaiMvG3fmMJks4YM2jcU4LspWhVUK0vAonYkmAtnLDFMDrS8hYij0EQ+Obp9qKDVXL8
         GViH8M+TuCyiLErjOv+Yum0spRGdR7iIKbmS6OCZyUtGH/i8oQJfuF0QlqN47aGZ5qTk
         A+MR7nrVFrg1Nc/JmAsTZ0SJSmJSBvuilUpoAkMcJpyK6QVORbBwvoNFU7p8zo4NKOzU
         26U/UD2pFf82Lls4SeY/1f193mABIS/jEK+0mKbpqYnqCsJJkwCsMA5Rgv089pom56UH
         RGnw==
X-Received: by 10.50.59.132 with SMTP id z4mr15705217igq.41.1432571544874;
        Mon, 25 May 2015 09:32:24 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:21e0:c856:141b:7701])
        by mx.google.com with ESMTPSA id o9sm9022939ioe.35.2015.05.25.09.32.23
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 25 May 2015 09:32:24 -0700 (PDT)
In-Reply-To: <CAJ80sas_D-6z4MvuFvvjoX7U_bM6b3brCo4rvYFCUfTmKS=6bA@mail.gmail.com>
	(Allen Hubbe's message of "Mon, 25 May 2015 08:47:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269845>

Allen Hubbe <allenbh@gmail.com> writes:

> Looking closer at this and the other test cases, they are inconsistent
> about using ".mailrc", "~/.mailrc", and "$(pwd)/.mailrc".  This would
> add another one, "$HOME/.mailrc".

In t9001, I see two tests on mailrc:

 * Create .mailrc in the current directory and point at it from the
   configuration file sendemail.aliasfile with $(pwd)/.mailrc

   This one is correct in that test wants to make sure an absolute
   path is usable as the value; the creation in the current
   directory (hence >.mailrc) is a mere implementation detail that
   the file it wants to use can be created by pathname relative to
   the current directory when "echo" is run.

 * Create ~/.mailrc, relying on tilde expansion of the shell when
   "echo" is run, and then point at it from the configuration file
   as "~/.mailrc".

   The former, i.e. "echo ... >~/.mailrc" should instead redirect
   into >$HOME/.mailrc in order to support shells that do not
   understand tilde expansion.  However, the latter is correct, as
   this test wants to make sure that whoever reads the configuration
   interprets ~/.mailrc as "file .mailrc in the home directory",
   without help from the shell.

Specifically, the difference between these two tests is not
inconcistency; they are covering two different use patterns.

So I do not see any reason to change most of these; except that the
target of 'echo' should be changed from ~/.mailrc to $HOME/.mailrc.

Thanks.
