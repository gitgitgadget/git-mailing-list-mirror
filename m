From: Jeff King <peff@peff.net>
Subject: Re: auto merge bug
Date: Tue, 5 Mar 2013 04:03:26 -0500
Message-ID: <20130305090326.GC13552@sigill.intra.peff.net>
References: <CAOFaZ+5F1BcWNU=AkcnS53bQt1VfAfsFjp9EvRCL=7kYiU1ejg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: David Krmpotic <david.krmpotic@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 05 10:04:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCnn3-0000kK-VT
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 10:04:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754950Ab3CEJDf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Mar 2013 04:03:35 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:35189 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752997Ab3CEJD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Mar 2013 04:03:28 -0500
Received: (qmail 12491 invoked by uid 107); 5 Mar 2013 09:05:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 05 Mar 2013 04:05:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Mar 2013 04:03:26 -0500
Content-Disposition: inline
In-Reply-To: <CAOFaZ+5F1BcWNU=AkcnS53bQt1VfAfsFjp9EvRCL=7kYiU1ejg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217438>

On Mon, Mar 04, 2013 at 05:46:48PM +0100, David Krmpotic wrote:

> We started working on a .NET app and the XML project file (.csproj)
> got corrupted (a few closing tag missing).
> 
> 79	     <Compile Include="SlovaricaForm.Designer.cs">
> 80	       <DependentUpon>SlovaricaForm.cs</DependentUpon>
> 81	+    <Compile Include="WebCamForm.cs">
> 82	+      <SubType>Form</SubType>
> 83	+    </Compile>
> 84	+    <Compile Include="WebCamForm.Designer.cs">
> 85	+      <DependentUpon>WebCamForm.cs</DependentUpon>
> 86	     </Compile>
> 
> between lines 80 and 81 there should be </Compile>
>
> [...]
>
> The problematic commit is here:
> 
> https://github.com/davidhq/logo_x/commit/e3e5fa4b60b7939999b2a8c44330312755b72f93

Thanks for an easy-to-reproduce report. The problem here is that your
.gitattributes file specifies the "union" merge driver for .csproj
(and other) files. From "git help attributes":

           union
               Run 3-way file level merge for text files, but take lines
               from both versions, instead of leaving conflict markers.
               This tends to leave the added lines in the resulting file
               in random order and the user should verify the result. Do
               not use this if you do not understand the implications.

Your <Compile> stanzas each end on an identical line. So it sees that
one side has:

  A
  B
  Z

and the other side has:

  C
  D
  Z

It realizes that the "Z" is common, so is not part of the conflict. But
in the normal 3-way merge case, the rest of it conflicts, so you get a
chance to inspect it. But with "union", it just silently concatenates
the conflicting bits.

I suspect you can run into other problems with "union" here, too,
because line order _does_ matter for you. It comes close to working if
both sides are just adding elements at the same level of the tree (as
you are here), but what about more complicated edits?

I think what you really want is an XML-aware merge tool that can see you
just added two independent <Compile>...</Compile> stanzas that can
co-exist (i.e., it could do a union, but at the level of XML tags, not
at the level of individual lines).  I do not know offhand of any such
tool (or for that matter, a good general XML-aware 3-way merge tool),
but if you had one, you could plug it in as a custom merge driver.

You might be able to get by with a version of the "union" driver that
asks the 3-way merge driver to be less aggressive about shrinking the
conflict blocks. For example, with this patch to git:

diff --git a/ll-merge.c b/ll-merge.c
index fb61ea6..61b1d4e 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -100,7 +100,6 @@ static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
 	}
 
 	memset(&xmp, 0, sizeof(xmp));
-	xmp.level = XDL_MERGE_ZEALOUS;
 	xmp.favor = opts->variant;
 	xmp.xpp.flags = opts->xdl_opts;
 	if (git_xmerge_style >= 0)

I think the merge will produce the results you are looking for. This
would have to be configurable, though, as it is a regression for
existing users of "union", which would want the duplicate-line
suppression (or maybe not; it will only catch such duplicates at the
beginning and end of the conflict hunk, so maybe it is sane to always
ask "union" to keep all lines).

I'd still worry about more complicated edits fooling "union", but at
least the simple cases would work.

In the meantime, I think you are better to drop those "merge"
gitattributes, and just let the regular three way merge generate a
conflict which you can inspect. For the merge in question, it yields:

  diff --cc Logo/Logo.csproj
  index 4113434,c681862..0000000
  --- a/Logo/Logo.csproj
  +++ b/Logo/Logo.csproj
  @@@ -67,17 -67,11 +67,25 @@@
        <Reference Include="System.Xml" />
      </ItemGroup>
      <ItemGroup>
  ++<<<<<<< HEAD
   +    <Compile Include="MainForm.cs">
   +      <SubType>Form</SubType>
   +    </Compile>
   +    <Compile Include="MainForm.Designer.cs">
   +      <DependentUpon>MainForm.cs</DependentUpon>
   +    </Compile>
   +    <Compile Include="SlovaricaForm.cs">
   +      <SubType>Form</SubType>
   +    </Compile>
   +    <Compile Include="SlovaricaForm.Designer.cs">
   +      <DependentUpon>SlovaricaForm.cs</DependentUpon>
  ++=======
  +     <Compile Include="WebCamForm.cs">
  +       <SubType>Form</SubType>
  +     </Compile>
  +     <Compile Include="WebCamForm.Designer.cs">
  +       <DependentUpon>WebCamForm.cs</DependentUpon>
  ++>>>>>>> bd1a059
        </Compile>
        <Compile Include="WordsSelectForm.cs">
          <SubType>Form</SubType>

where you can see that it "shrinks" the conflict hunk to not include the
line added by both sides (the file "</Compile>" after the conflict). But
by triggering a conflict, you can actually look at and fix it. That's
more work, of course.

Another alternate is to keep the "union" driver and just do better
testing of merges. Even with the stock 3-way driver, a merge that
auto-resolves is not necessarily correct (e.g., even if there are not
textual conflicts, there may be semantic ones).

-Peff
