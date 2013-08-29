From: worley@alum.mit.edu (Dale R. Worley)
Subject: Re: the pager
Date: Thu, 29 Aug 2013 11:41:56 -0400
Message-ID: <201308291541.r7TFfuJr023110@freeze.ariadne.com>
References: <201308261957.r7QJvfjF028935@freeze.ariadne.com>
        <xmqqd2ozhhob.fsf@gitster.dls.corp.google.com>
        <201308281819.r7SIJmnh025977@freeze.ariadne.com> <xmqqr4dd8suz.fsf@gitster.dls.corp.google.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 29 17:42:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF4MG-0001d9-4G
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 17:42:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755165Ab3H2Pl7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 11:41:59 -0400
Received: from qmta02.westchester.pa.mail.comcast.net ([76.96.62.24]:59754
	"EHLO qmta02.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755112Ab3H2Pl6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Aug 2013 11:41:58 -0400
Received: from omta07.westchester.pa.mail.comcast.net ([76.96.62.59])
	by qmta02.westchester.pa.mail.comcast.net with comcast
	id JeTi1m0051GhbT851fhx8h; Thu, 29 Aug 2013 15:41:57 +0000
Received: from freeze.ariadne.com ([24.34.72.61])
	by omta07.westchester.pa.mail.comcast.net with comcast
	id Jfhx1m00N1KKtkw3TfhxJJ; Thu, 29 Aug 2013 15:41:57 +0000
Received: from freeze.ariadne.com (freeze.ariadne.com [127.0.0.1])
	by freeze.ariadne.com (8.14.5/8.14.5) with ESMTP id r7TFfurs023111;
	Thu, 29 Aug 2013 11:41:56 -0400
Received: (from worley@localhost)
	by freeze.ariadne.com (8.14.5/8.14.5/Submit) id r7TFfuJr023110;
	Thu, 29 Aug 2013 11:41:56 -0400
In-reply-to: <xmqqr4dd8suz.fsf@gitster.dls.corp.google.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1377790917;
	bh=APTjdGs5f/OUN0YvzNK3aFBUq/GP5y2FZKDWpu11kPw=;
	h=Received:Received:Received:Received:Date:Message-Id:From:To:
	 Subject;
	b=N7iYWdHLogcoKEv3SqHHrj1xvfrLfLa3q3Wxvxkq81JZSDIHrDNXJsEMI8nWSSQ3t
	 GJ078lqxhVsVIF4zmhE/v78BgXgazUBJHWy6ujy4OMmyvBfI+A/mTMFenClsYMk/cO
	 Lk5ova09g9OcLorvJhezoNroPaaAfaF14Aav6nDWWih+6OItWU5MMfkBwaMwcuKmRD
	 lpIOlzYHuaLZf1ovvn04vtmV7PgJHjSDd4keKsTlwFTrxb5UpQxJMQnJeKiMPiGOYv
	 /ps0dMZA+stCbMa0vV022W/oHPFnbCZ1EkI4TZhSpjgbQArsGUXumqX7jIQBIbCl5J
	 /lwBBYQQ47LqA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233278>

So I set out to verify in the code that the order of priority of pager
specification is

    GIT_PAGER > core.pager > PAGER > default

I discovered that there is also a pager.<command> configuration
variable.

I was expecting the code to be simple, uniform (with regard to the 5
sources), and reasonably well documented.  The relevant parts of the
code that I have located so far include:

in environment.c:

    const char *pager_program;

in config.c:

    int git_config_with_options(config_fn_t fn, void *data,
                                const char *filename,
                                const char *blob_ref,
                                int respect_includes)
    {
            char *repo_config = NULL;
            int ret;
            struct config_include_data inc = CONFIG_INCLUDE_INIT;

            if (respect_includes) {
                    inc.fn = fn;
                    inc.data = data;
                    fn = git_config_include;
                    data = &inc;
            }

            /*
             * If we have a specific filename, use it. Otherwise, follow the
             * regular lookup sequence.
             */
            if (filename)
                    return git_config_from_file(fn, filename, data);
            else if (blob_ref)
                    return git_config_from_blob_ref(fn, blob_ref, data);

            repo_config = git_pathdup("config");
            ret = git_config_early(fn, data, repo_config);
            if (repo_config)
                    free(repo_config);
            return ret;
    }

in pager.c:

    /* returns 0 for "no pager", 1 for "use pager", and -1 for "not specified" */
    int check_pager_config(const char *cmd)
    {
            struct pager_config c;
            c.cmd = cmd;
            c.want = -1;
            c.value = NULL;
            git_config(pager_command_config, &c);
            if (c.value)
                    pager_program = c.value;
            return c.want;
    }

    const char *git_pager(int stdout_is_tty)
    {
            const char *pager;

            if (!stdout_is_tty)
                    return NULL;

            pager = getenv("GIT_PAGER");
            if (!pager) {
                    if (!pager_program)
                            git_config(git_default_config, NULL);
                    pager = pager_program;
            }
            if (!pager)
                    pager = getenv("PAGER");
            if (!pager)
                    pager = DEFAULT_PAGER;
            else if (!*pager || !strcmp(pager, "cat"))
                    pager = NULL;

            return pager;
    }

What's with the code?  It's not simple, it's not uniform (e.g.,
setting env. var. PAGER to "cat" will cause git_pager() to return
NULL, but setting preprocessor var. DEFAULT_PAGER to "cat" will cause
it to return "cat"), and it's barely got any comments at all (a global
variable has *no description whatsoever*).

I'd like to clean up the manual pages at least, but it would take me
hours to figure out what the code *does*.

I know I'm griping here, but I thought that part of the reward for
contributing to an open-source project was as a showcase of one's
work.  Commenting your code is what you learn first in programming.

Dale
