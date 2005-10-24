From: Morten Welinder <mwelinder@gmail.com>
Subject: The MIT error
Date: Mon, 24 Oct 2005 14:57:15 -0400
Message-ID: <118833cc0510241157j39d5ff2cib2ccea50d15210d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Oct 24 20:58:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EU7VZ-0003Yg-KO
	for gcvg-git@gmane.org; Mon, 24 Oct 2005 20:57:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbVJXS5R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Oct 2005 14:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750908AbVJXS5R
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Oct 2005 14:57:17 -0400
Received: from qproxy.gmail.com ([72.14.204.207]:62510 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750801AbVJXS5Q convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2005 14:57:16 -0400
Received: by qproxy.gmail.com with SMTP id e12so291888qbe
        for <git@vger.kernel.org>; Mon, 24 Oct 2005 11:57:15 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=gRySDRFq/tP6XXjMeX84CuJxn56g9lehBqMNnl7oEXWf91/lVUjAALA4yF+Za11oL8W2HEjF1k2Xs70fGHn5R1u+K7f35xuOtFm2dSieos4rAIiGyJsBddT8DQHJmcTXCepJ7LYHkvB/Uutt7BpZWFPp/NYKKq7vv5Mgl6h8W/o=
Received: by 10.65.83.8 with SMTP id k8mr650209qbl;
        Mon, 24 Oct 2005 11:57:15 -0700 (PDT)
Received: by 10.65.107.12 with HTTP; Mon, 24 Oct 2005 11:57:15 -0700 (PDT)
To: GIT Mailing List <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10554>

After the isspace/BSD conflict I looked into what reserved symbols are
being used by git.  Quite a few, it turns out.

--M.


The C standard says you should not use identifiers matching:

    (is|to)[a-z].*                         <-- such as isize
    E[0-9A-Z].*                         <-- such as EMIT
    str[a-z].*                              <-- such as strbuf
    (PRI|SCN)[a-zX].*
    LC_[A-Z].*
    (SIG|SIG_)[A-Z].*
    (uint|int).*_t
    (UINT|INT).*_(MIN|MAX|C)
    wcs[a-z].*

The three top ones are the easiest to violate.  While fixing the existing
violations is probably pointless, new code ought not make things worse.

Just as isspace is reserved by the C implementation...

       7.26.2  Character handling <ctype.h>

       [#1]  Function  names that begin with either is or to, and a
       lowercase letter (possibly followed by  any  combination  of
       digits,  letters,  and  underscore)  may  be  added  to  the
       declarations in the <ctype.h> header.

[so there goes any use of "isize"], so are macro names EMIT, ETHIS,
and ETHAT, at least when <errno.h> is included.

      7.26.3  Errors <errno.h>

       [#1] Macros that begin with E  and  a  digit  or  E  and  an
       uppercase  letter  (possibly  followed by any combination of
       digits,  letters,  and  underscore)  may  be  added  to  the
       declarations in the <errno.h> header.

quote.c:#undef EMIT
quote.c:#define EMIT(x) ( (++len < n) && (*bp++ = (x)) )
quote.c:#define EMITQ() EMIT('\\')
server-info.c:#define EMITTED   04
tar-tree.c:#define EXT_HEADER_PATH              1
tar-tree.c:#define EXT_HEADER_LINKPATH  2
ls-files.c:#define EXC_CMDL 0
ls-files.c:#define EXC_DIRS 1
ls-files.c:#define EXC_FILE 2
epoch.h:#define EPOCH_H
update-index.c:static inline void *ERR_PTR(long error)

        7.26.10  General utilities <stdlib.h>

       [#1] Function names that begin  with  str  and  a  lowercase
       letter  (possibly  followed  by  any  combination of digits,
       letters, and underscore) may be added to the declarations in
       the <stdlib.h> header.
