From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/9] send-email: further document missing sendmail
 aliases functionality
Date: Mon, 1 Jun 2015 14:22:36 -0400
Message-ID: <20150601182236.GA28030@flurp.local>
References: <1433111371-19573-1-git-send-email-sunshine@sunshineco.com>
 <1433111371-19573-2-git-send-email-sunshine@sunshineco.com>
 <CAJ80sau0GeeFxFZYsEE=uupfPqJ=vRZfNRuNd0qRJPDNvnbMPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Allen Hubbe <allenbh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 20:22:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzUMK-0006Hd-7E
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 20:22:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753437AbbFASWn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 14:22:43 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:33675 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753736AbbFASWm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 14:22:42 -0400
Received: by iebgx4 with SMTP id gx4so115275979ieb.0
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 11:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Y98nCg91cKzvP86R/skXRZloo5aD2LfCKGqVWeHLg2U=;
        b=saHoEgB+LcyceDlBVBxJvjq9FpDw/PzG3VNmw7FeLtLdAoQYDxHEaUEKSCsL4MbkCP
         MzEX0HbHz1XxNkSNUuYjLcAAGjpjszIKefem3FQ3hvKVXSfCITJGRzO6pwYVCDE8tCeF
         y5+suhldUe9KVIyTdXLO1zW0eB3bTQtXs/+ES1iChkceFcB+uUxvtZpPuMRYBflgCIwT
         UYGna1Z2FSDGEcF6CvDJ7pwXqlJ1AfvPvFjCYWoJndw1JdhxSuPcAbjN4znEhMYOeR56
         kTGSNJLHxgKznQW1pnlQ2uSbeqQz8eth+5KklpWw168T3eTh9/6Wwn8z/Um0mkjt+QPc
         08cg==
X-Received: by 10.107.26.207 with SMTP id a198mr28458788ioa.5.1433182962179;
        Mon, 01 Jun 2015 11:22:42 -0700 (PDT)
Received: from flurp.local (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id q85sm10919479ioi.6.2015.06.01.11.22.41
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 01 Jun 2015 11:22:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJ80sau0GeeFxFZYsEE=uupfPqJ=vRZfNRuNd0qRJPDNvnbMPw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270452>

On Mon, Jun 01, 2015 at 07:43:08AM -0400, Allen Hubbe wrote:
> On May 31, 2015 at 6:29 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> > Sendmail aliases[1] supports expansion to a file ("/path/name") or
> > pipe ("|command"), as well as file inclusion (":include: /path/name"),
> > however, our implementation does not support such functionality.
>
> According to the documentation, the parser should print a warning for
> any explicitly unsupported constructs.  These are now explicitly
> unsupported, so the parser should warn on |, /, and :include: .
> Perhaps the lines that match should be ignored like the others, too.

Indeed. I had that in mind and then promptly forgot about it. Here's a
follow-on patch:

--- >8 ---
From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 10/9] send-email: further warn about unsupported sendmail aliases features

The sendmail aliases parser diagnoses unsupported features and
unrecognized lines. For completeness, also warn about unsupported
redirection to "/path/name" and "|command", as well as ":include:".

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 git-send-email.perl | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/git-send-email.perl b/git-send-email.perl
index eb1d678..ae9f869 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -492,6 +492,10 @@ sub parse_sendmail_alias {
 	local $_ = shift;
 	if (/"/) {
 		print STDERR "warning: sendmail alias with quotes is not supported: $_\n";
+	} elsif (/:include:/) {
+		print STDERR "warning: `:include:` not supported: $_\n";
+	} elsif (/[\/|]/) {
+		print STDERR "warning: `/file` or `|pipe` redirection not supported: $_\n";
 	} elsif (/^(\S+?)\s*:\s*(.+)$/) {
 		my ($alias, $addr) = ($1, $2);
 		$aliases{$alias} = [ split_addrs($addr) ];
-- 
2.4.2.538.g5f4350e

--- >8 ---
