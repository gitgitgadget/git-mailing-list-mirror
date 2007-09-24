From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Supplant the "while case ... break ;; esac" idiom
Date: Mon, 24 Sep 2007 10:29:57 +0200
Message-ID: <867imgwjne.fsf@lola.quinscape.zz>
References: <853ax5mb1j.fsf@lola.goethe.zz> <85myvdktb3.fsf@lola.goethe.zz> <20070924060521.GB10975@glandium.org> <85k5qgk295.fsf@lola.goethe.zz> <ee77f5c20709232330n7b47d9e9v38677678dbf197da@mail.gmail.com> <86ejgowl5g.fsf@lola.quinscape.zz> <20070924080134.GA9112@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 24 10:30:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZjKr-0002Fv-4S
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 10:30:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754778AbXIXIa0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 04:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753456AbXIXIa0
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 04:30:26 -0400
Received: from main.gmane.org ([80.91.229.2]:45011 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754206AbXIXIaZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 04:30:25 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IZjKb-0001h5-W1
	for git@vger.kernel.org; Mon, 24 Sep 2007 08:30:17 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 24 Sep 2007 08:30:17 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 24 Sep 2007 08:30:17 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:ApoJ+uu1r2Ib4AyyL7bPPxwSEsc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59030>

Pierre Habouzit <madcoder@debian.org> writes:

> On Mon, Sep 24, 2007 at 07:57:31AM +0000, David Kastrup wrote:
>> "David Symonds" <dsymonds@gmail.com> writes:
>> 
>> > On 24/09/2007, David Kastrup <dak@gnu.org> wrote:
>> >> Mike Hommey <mh@glandium.org> writes:
>> >>
>> >> > On Sun, Sep 23, 2007 at 10:42:08PM +0200, David Kastrup wrote:
>> >> >> -while case $# in 0) break ;; esac
>> >> >> +while test $# != 0
>> >> >
>> >> > Wouldn't -ne be better ?
>> >>
>> >> Why?
>> >
>> > Because -ne does a numeric comparison, != does a string comparison,
>> > and it's a numeric comparison happening, semantically speaking.
>> 
>> I don't see the point in converting $# and 0 into numbers before
>> comparing them.  "!=" is quite more readable, and the old code also
>> compared the strings.
>
>   Fwiw $# already is a number.

It isn't.

> Hence test $# -ne 0 is definitely a better test.

/* TEST/[ builtin. */
int
test_builtin (list)
     WORD_LIST *list;
{
  char **argv;
  int argc, result;

  /* We let Matthew Bradburn and Kevin Braunsdorf's code do the
     actual test command.  So turn the list of args into an array
     of strings, since that is what their code wants. */
  if (list == 0)
    {
      if (this_command_name[0] == '[' && !this_command_name[1])
	{
	  builtin_error ("missing `]'");
	  return (EX_BADUSAGE);
	}

      return (EXECUTION_FAILURE);
    }

  argv = make_builtin_argv  (list, &argc);
  result = test_command (argc, argv);
  free ((char *)argv);

  return (result);
}

>   $# != 0 would yield sth like (strcmp(sprintf("%d", argc), "0"))
>   $# -ne 0 would yield sth like (argc != atoi("0")).
>
>   Not that it matters much, but the latter looks better to me.

Not to me.  The code does not support your argument, and all $x
expansions certainly are strings, according to manual and usage.  I
will rework the patch this evening in order to get a commit message
more placable to Junio, and I will at his request remove all of the
(redundant) quoting.  But removing quoting from $# does not turn it
into a number: it remains the same string '0'.  If someone else feels
he should replace all "=" and "!=" tests for "numeric" comparisons
with the unreadable numeric tests, he can go ahead proposing a
separate patch that should not just cover $#.

You can have bash declare numeric variables, but even they are strings
(they just auto-evaluate on assignment):

declare -i nonsense
nonsense="3+$(echo 4)"
echo "$nonsense"

gives 7, even though everything has been "strings" here.

-- 
David Kastrup
