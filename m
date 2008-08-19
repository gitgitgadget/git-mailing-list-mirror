From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH 2/3 v2] add new Perl API: Git::Repo, Git::Commit, Git::Tag,
 and Git::RepoRoot
Date: Tue, 19 Aug 2008 15:51:03 +0200
Message-ID: <48AACFC7.6070806@gmail.com>
References: <1219088389-14828-1-git-send-email-LeWiemann@gmail.com> <1219088389-14828-2-git-send-email-LeWiemann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 15:52:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVRd6-0002WE-Pv
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 15:52:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509AbYHSNvH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 09:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752031AbYHSNvH
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 09:51:07 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:44729 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751985AbYHSNvD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 09:51:03 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2529975fkq.5
        for <git@vger.kernel.org>; Tue, 19 Aug 2008 06:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=IACYDAyUAB7jeu8YptJ8If/+rm7QaVqynO4fR/4dP30=;
        b=ozwR8bSFDXZgqMPOS+jbgoV0P4yU0g6nP3hvCvSNuH5hXwls6yP7NzYoIPzkEjcj2r
         vyiBiac5QFUzQ1YIvVbeOjdM36pwbbe6ToKjK0AfU68TdPQDrSQ5igZkZaAsrUrFfcCe
         UkrwLPD/YcvCpgohreC1AhIaC54hOrZqeEJ6M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=IlkzPtk552E/ZTGHxbxuEXt8wgNk0fcv4FjPmD9DCfG7DjHVzUdUm5Kc37fqd6Owf0
         l0Ies+jJG6DBYLUZpSthQIkdlt+7SAvTWmyIWGQCqox3shQYAwgRjc0vbAONTctAgpGJ
         GCFfa7K7n7IItigdPDzd1xulesNeZXAQ7QBlA=
Received: by 10.180.209.8 with SMTP id h8mr4133754bkg.10.1219153861872;
        Tue, 19 Aug 2008 06:51:01 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.210.90])
        by mx.google.com with ESMTPS id 22sm137025fkr.4.2008.08.19.06.51.00
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 19 Aug 2008 06:51:00 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.16) Gecko/20080707 Thunderbird/2.0.0.16 Mnenhy/0.7.5.666
In-Reply-To: <1219088389-14828-2-git-send-email-LeWiemann@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92861>

Since I didn't mention it: The patch series applies on next.


Lea Wiemann wrote:
> +Git::Repo - Read-only access to the Git repositories.
> +
> +Error handling is simple: On a consistent repository, the Perl
> +interface will never die.  You can use the get_sha1 method to resolve
> +arbitrary object names or check the existence of SHA1 hashes; get_sha1
> +will return undef if the object does not exist in the repository.  Any
> +SHA1 that is returned by get_sha1 can be safely passed to the other
> +Git::Repo methods.

Here's some elaboration on the rationale behind the error handling.  As
a reminder, what we do is force developers to resolve object identifiers
(such as HEAD^) into SHA1s first, rather than allowing them to pass in
arbitrary object identifiers into functions.  Here's why:

a) There's really just one point where errors can occur: at the input
boundary (like the command line).  Hence, you usually need one to three
get_sha1 calls to resolve your input object names, and the rest of your
program will be error-handling free with regard to Git::Repo (that is,
if it dies it's either a bug or an error in the repository structure).

On the other hand, if you don't have such an explicit error-checking
boundary at the beginning of your program (where you resolve all
identifiers), you basically allow invalid object identifiers to "creep"
into your code.  For instance, gitweb oftentimes would have statements
like "or die 'ls-tree failed'" or "or die 'commit not found'" deep
inside a function -- in some cases, I found out that these failures
*could* not even happen since the objects were guaranteed to exist by
earlier calls (and hence it was basically dead code); and in many cases
the error messages were simply non-descript -- which brings me to the
next point:

b) Error reporting is really hard to implement: For instance, if
diff-tree returns non-zero, then unless you scrape its STDERR, you can't
tell which of the two to-be-diffed objects didn't exist (or had the
wrong type), and hence you're oftentimes stuck with a generic 'diff-tree
failed' message.  In other words, if a simple diff-tree call goes wrong,
there are three possible causes: (1) The left object is invalid, (2) the
right object is invalid, (3) something fatal happened (bug or repository
breakage).  Distinguishing these cases is hard, and moving the
object-resolving code to the beginning of the API user's program means
that diff-tree failure can only indicate case (3).

c) The error messages you could get from an API are not usually what you
want anyway.  So if you write

     my $diff = diff_tree($obj_identifier_1, $obj_identifier_2)

and expect it to die with a descriptive error message if one of the two
identifiers doesn't point to a valid tree object, the best your error
message can possibly be is "git diff-tree: HEAD^:foo/bar is not a valid
tree object".  Which leaves users puzzled because (1) they didn't call
diff-tree, and (2) the program might have constructed the
"HEAD^:foo/bar" string, and they only passed in parts of it, so it's not
clear to them where "HEAD^:foo/bar" comes from.

d) Last but not least, using exceptions to communicate errors is against
Perl coding conventions -- I would even have to look up the syntax to
check for a specific exception type after an 'eval' block, because I
simply never needed it.

So I think those four reasons really prevail over the extra work of
having to make 1-3 get_sha1 calls at the beginning of your program (and
providing proper error messages if they fail).
