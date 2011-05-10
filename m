From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/2] completion: suppress zsh's special 'words' variable
Date: Mon, 9 May 2011 21:59:16 -0500
Message-ID: <20110510025916.GB26619@elie>
References: <BANLkTikkhryMa69DSx4EAYjw+aar4icKcQ@mail.gmail.com>
 <1304979299-6496-1-git-send-email-felipe.contreras@gmail.com>
 <20110510025529.GA26619@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 10 04:59:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJdAT-0001lv-R8
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 04:59:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753455Ab1EJC7V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 May 2011 22:59:21 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:41187 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753243Ab1EJC7U convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2011 22:59:20 -0400
Received: by iwn34 with SMTP id 34so4858492iwn.19
        for <git@vger.kernel.org>; Mon, 09 May 2011 19:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=pYgLDQlN+PpHo+P7ah2igDsn5tvd9/qurp8NPZVvBjo=;
        b=AtrxWXoSs9UrpuxD7+TTi0XqalNeCdsm5RaLyxDgjPI2jvJImzPKvCLBogOuWXAslL
         EI/rKdsmQH/Xx8foFFIUUq0VnXggCNsdNM3G4xQAVVlflLYMirg+UzFgnOgW07iEVxnX
         7+XXS4o9wAQguc5R+szrDapK5uxUZ6qVUOK7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=LdwUNxCXM7r+gamJBrEi1lNLXhbWklMdx+ndDUzFews6hCCuXDIxaGIgAZgxZkYspP
         jYyc78QgQFtv+h3fa611FCE4PlHbMNooR8yDxhZCbk6Z0zu79XV0xvjgq/GaKf6cbVSJ
         jKgjsoMtQH/7gWGdkfZ+7KAIFoI5DL2utME3Q=
Received: by 10.231.113.214 with SMTP id b22mr5205821ibq.102.1304996360356;
        Mon, 09 May 2011 19:59:20 -0700 (PDT)
Received: from elie (wireless-165-232.uchicago.edu [128.135.165.232])
        by mx.google.com with ESMTPS id 19sm2901429ibx.18.2011.05.09.19.59.18
        (version=SSLv3 cipher=OTHER);
        Mon, 09 May 2011 19:59:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110510025529.GA26619@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173300>

=46rom: Felipe Contreras <felipe.contreras@gmail.com>

After git's tab completion script gained zsh support in
v1.7.4-rc0~169^2 (completion: make compatible with zsh, 2010-09-06)
it was broken moments later.  More precisely, the completion does not
notice when it has seen a subcommand name, so all words complete as
options to the git wrapper or subcommand names.  For example, typing
"git log origi<TAB>" gives no completions because there are no "git
origi..." commands.

The cause: it turns out 'words' is one of the special parameters used
by the zsh completion system, used to hold the words from the command
it is completing.  As a result (in the words of zshcompwid(1)):

	[...] the parameters are reset on each function exit
	(including nested function calls from within the completion
	widget) to the values they had when the function was entered.

Each function in git's completion script using the 'words' array

 - declares "local words", causing the array to be cleared (but not
   resetting the special attribute);

 - calls "_get_comp_words_by_ref -n :=3D words" to fill it with a
   modified version of COMP_WORDS with ':' and '=3D' no longer treated
   as word separators (see v1.7.4-rc0~11^2~2, 2010-12-02).  Within
   _get_comp_words_by_ref all is well, and when the function returns,
   words is reset to its former value;

 - examines $words and finds it empty.

=46ix it by suppressing the special 'words' variable with typeset -h
so it can be used as an ordinary array.  The only risk is that the
completion script might call a function that wants to inspect the
'words' variable, expecting the zsh-specific meaning; luckily the next
version of zsh's bashcompinit (e880604f, 29140: hide the "words"
special variable so that it may be used as an ordinary variable by
bash completions, 2011-05-04) will also use 'typeset -h words' when
calling completion functions so

 - soon this fix will be redundant :)
 - anyone else using the bashcompinit library is risking the same
   problem, so presumably other functions from that library are
   carefully written to only look at $COMP_WORDS and not $words.

This fixes a regression introduced by v1.7.4-rc0~11^2~2 (2010-12-02).

Reported-by: Stefan Haller <lists@haller-berlin.de>
Improved-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 contrib/completion/git-completion.bash |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index b81f444..da586e5 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2608,6 +2608,7 @@ _git ()
 	if [[ -n ${ZSH_VERSION-} ]]; then
 		emulate -L bash
 		setopt KSH_TYPESET
+		typeset -h words
 	fi
=20
 	local cur words cword prev
@@ -2659,6 +2660,7 @@ _gitk ()
 	if [[ -n ${ZSH_VERSION-} ]]; then
 		emulate -L bash
 		setopt KSH_TYPESET
+		typeset -h words
 	fi
=20
 	local cur words cword prev
--=20
1.7.5.1
