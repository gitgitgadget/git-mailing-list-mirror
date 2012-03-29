From: Jeff King <peff@peff.net>
Subject: top-level gitignore considered harmful
Date: Thu, 29 Mar 2012 17:11:36 -0400
Message-ID: <20120329211136.GA1112@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Jay Soffian <jaysoffian@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 29 23:11:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDMdI-0004QF-FR
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 23:11:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933045Ab2C2VLn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 17:11:43 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39701
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753850Ab2C2VLl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 17:11:41 -0400
Received: (qmail 6583 invoked by uid 107); 29 Mar 2012 21:11:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 29 Mar 2012 17:11:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Mar 2012 17:11:36 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194294>

So we were sitting around chatting today about how slow "git status" is
in the gigantic WebKit repository (because really, what else would one
chat about?). Carlos noticed that git spends a lot of time in the
gitignore code path.  It turns out that the WebKit repository has a
couple hundred excludes in the top-level .gitignore, many of which are
for specific files deep in the repository.

Since these patterns are compared via fnmatch(), we have to process them
linearly for each entry[1]. And since the patterns are at the top level,
we check them for each of the ~180,000 files in the repository. So "git
status" will do O(m*n) work, where "m" is the number of patterns and "n"
is the number of files in the repository. And as a project grows over
time, one might expect "m" to be some constant factor of "n". So this is
really O(n^2) (albeit with some mitigating constant at the front).

All of which is to say: things can be made much faster by pushing the
patterns to their respective sub-directories, because git is smart
enough not to even look at patterns from other sub-directories. With the
patch below to WebKit, rearranging its .gitignore and .gitattributes
entries, I measured the following speedup for "git status" (warm cache,
best-of-five):

  before:
  real    0m1.365s
  user    0m0.996s
  sys     0m0.364s
  
  after:
  real    0m0.847s
  user    0m0.520s
  sys     0m0.320s

None of this should be too surprising to anybody who has looked at the
gitignore code. But I was a little surprised by the magnitude of the
speedup. So I figured it was worth mentioning here as a case study.

I'm not going to push this patch forward to WebKit myself. I don't work
on it, and the split of the gitattributes and gitignore files in the
patch was purely mechanical (converting .gitignore:foo/bar/baz into
foo/bar/.gitignore:baz). Somebody more familiar with the project would
probably want to group the entries in a more logical way for the project
(e.g., foo/.gitignore:bar/baz).

-Peff

[1] So obviously this is about something that projects can do to help
    git run faster on them. But we could do better in git, too. fnmatch
    patterns need to be examined linearly because of wildcards. But
    many patterns don't have wildcards, or the wildcards come much later
    in the pattern. There's no reason we couldn't preprocess the
    patterns into a data structure with fast lookup properties, grouped
    by non-wildcard prefixes (so seeing "foo/bar/*.baz", we could build
    a trie that lets us reject "other/directory" after only a
    single-character match).

---
This is the patch against WebKit:

diff --git a/.gitattributes b/.gitattributes
index 95ca4eb..af87a9a 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -18,228 +18,3 @@ Tools/WebKitLauncher/*.h diff=objcppheader
 *.vcproj eol=crlf
 *.vsprops eol=crlf
 *.sln eol=crlf
-
-LayoutTests/dom/svg/level3/xpath/Attribute_Nodes.svg -crlf
-LayoutTests/dom/svg/level3/xpath/Attribute_Nodes_xmlns.svg -crlf
-LayoutTests/dom/svg/level3/xpath/Comment_Nodes.svg -crlf
-LayoutTests/dom/svg/level3/xpath/Conformance_Expressions.svg -crlf
-LayoutTests/dom/svg/level3/xpath/Conformance_ID.svg -crlf
-LayoutTests/dom/svg/level3/xpath/Conformance_hasFeature_3.svg -crlf
-LayoutTests/dom/svg/level3/xpath/Conformance_hasFeature_empty.svg -crlf
-LayoutTests/dom/svg/level3/xpath/Conformance_hasFeature_null.svg -crlf
-LayoutTests/dom/svg/level3/xpath/Conformance_isSupported_3.svg -crlf
-LayoutTests/dom/svg/level3/xpath/Conformance_isSupported_empty.svg -crlf
-LayoutTests/dom/svg/level3/xpath/Conformance_isSupported_null.svg -crlf
-LayoutTests/dom/svg/level3/xpath/Element_Nodes.svg -crlf
-LayoutTests/dom/svg/level3/xpath/Processing_Instruction_Nodes.svg -crlf
-LayoutTests/dom/svg/level3/xpath/Text_Nodes.svg -crlf
-LayoutTests/dom/svg/level3/xpath/XPathEvaluatorCast01.svg -crlf
-LayoutTests/dom/svg/level3/xpath/XPathEvaluator_createExpression_INVALID_EXPRESSION_ERR.svg -crlf
-LayoutTests/dom/svg/level3/xpath/XPathEvaluator_createExpression_NAMESPACE_ERR_01.svg -crlf
-LayoutTests/dom/svg/level3/xpath/XPathEvaluator_createExpression_NAMESPACE_ERR_02.svg -crlf
-LayoutTests/dom/svg/level3/xpath/XPathEvaluator_createExpression_NS.svg -crlf
-LayoutTests/dom/svg/level3/xpath/XPathEvaluator_createExpression_no_NS.svg -crlf
-LayoutTests/dom/svg/level3/xpath/XPathEvaluator_createNSResolver_all.svg -crlf
-LayoutTests/dom/svg/level3/xpath/XPathEvaluator_createNSResolver_document.svg -crlf
-LayoutTests/dom/svg/level3/xpath/XPathEvaluator_createNSResolver_documentElement.svg -crlf
-LayoutTests/dom/svg/level3/xpath/XPathEvaluator_evaluate_INVALID_EXPRESSION_ERR.svg -crlf
-LayoutTests/dom/svg/level3/xpath/XPathEvaluator_evaluate_NAMESPACE_ERR.svg -crlf
-LayoutTests/dom/svg/level3/xpath/XPathEvaluator_evaluate_NOT_SUPPORTED_ERR.svg -crlf
-LayoutTests/dom/svg/level3/xpath/XPathEvaluator_evaluate_TYPE_ERR.svg -crlf
-LayoutTests/dom/svg/level3/xpath/XPathEvaluator_evaluate_WRONG_DOCUMENT_ERR.svg -crlf
-LayoutTests/dom/svg/level3/xpath/XPathEvaluator_evaluate_document.svg -crlf
-LayoutTests/dom/svg/level3/xpath/XPathEvaluator_evaluate_documentElement.svg -crlf
-LayoutTests/dom/svg/level3/xpath/XPathExpression_evaluate_NOT_SUPPORTED_ERR.svg -crlf
-LayoutTests/dom/svg/level3/xpath/XPathExpression_evaluate_WRONG_DOCUMENT_ERR.svg -crlf
-LayoutTests/dom/svg/level3/xpath/XPathExpression_evaluate_document.svg -crlf
-LayoutTests/dom/svg/level3/xpath/XPathExpression_evaluate_documentElement.svg -crlf
-LayoutTests/dom/svg/level3/xpath/XPathNSResolver_lookupNamespaceURI_nist_dmstc.svg -crlf
-LayoutTests/dom/svg/level3/xpath/XPathNSResolver_lookupNamespaceURI_null.svg -crlf
-LayoutTests/dom/svg/level3/xpath/XPathNSResolver_lookupNamespaceURI_prefix.svg -crlf
-LayoutTests/dom/svg/level3/xpath/XPathNSResolver_lookupNamespaceURI_xml.svg -crlf
-LayoutTests/dom/svg/level3/xpath/XPathResult_TYPE_ERR.svg -crlf
-LayoutTests/dom/svg/level3/xpath/XPathResult_booleanValue_false.svg -crlf
-LayoutTests/dom/svg/level3/xpath/XPathResult_booleanValue_true.svg -crlf
-LayoutTests/dom/svg/level3/xpath/XPathResult_invalidIteratorState_ANY_TYPE.svg -crlf
-LayoutTests/dom/svg/level3/xpath/XPathResult_invalidIteratorState_ANY_UNORDERED_NODE_TYPE.svg -crlf
-LayoutTests/dom/svg/level3/xpath/XPathResult_invalidIteratorState_BOOLEAN_TYPE.svg -crlf
-LayoutTests/dom/svg/level3/xpath/XPathResult_invalidIteratorState_FIRST_ORDERED_NODE_TYPE.svg -crlf
-LayoutTests/dom/svg/level3/xpath/XPathResult_invalidIteratorState_NUMBER_TYPE.svg -crlf
-LayoutTests/dom/svg/level3/xpath/XPathResult_invalidIteratorState_ORDERED_NODE_ITERATOR_TYPE.svg -crlf
-LayoutTests/dom/svg/level3/xpath/XPathResult_invalidIteratorState_ORDERED_NODE_SNAPSHOT_TYPE.svg -crlf
-LayoutTests/dom/svg/level3/xpath/XPathResult_invalidIteratorState_STRING_TYPE.svg -crlf
-LayoutTests/dom/svg/level3/xpath/XPathResult_invalidIteratorState_UNORDERED_NODE_ITERATOR_TYPE.svg -crlf
-LayoutTests/dom/svg/level3/xpath/XPathResult_invalidIteratorState_UNORDERED_NODE_SNAPSHOT_TYPE.svg -crlf
-LayoutTests/dom/svg/level3/xpath/XPathResult_iterateNext_INVALID_STATE_ERR.svg -crlf
-LayoutTests/dom/svg/level3/xpath/XPathResult_iteratorNext_ORDERED_NODE_ITERATOR_TYPE.svg -crlf
-LayoutTests/dom/svg/level3/xpath/XPathResult_numberValue.svg -crlf
-LayoutTests/dom/svg/level3/xpath/XPathResult_resultType.svg -crlf
-LayoutTests/dom/svg/level3/xpath/XPathResult_singleNodeValue_ANY_UNORDERED_NODE_TYPE.svg -crlf
-LayoutTests/dom/svg/level3/xpath/XPathResult_singleNodeValue_FIRST_ORDERED_NODE_TYPE.svg -crlf
-LayoutTests/dom/svg/level3/xpath/XPathResult_snapshotItem_ORDERED_NODE_SNAPSHOT_TYPE_null.svg -crlf
-LayoutTests/dom/svg/level3/xpath/XPathResult_snapshotItem_ORDERED_NODE_SNAPSHOT_TYPE_order.svg -crlf
-LayoutTests/dom/svg/level3/xpath/XPathResult_snapshotItem_UNORDERED_NODE_SNAPSHOT_TYPE_count.svg -crlf
-LayoutTests/dom/svg/level3/xpath/XPathResult_snapshotItem_UNORDERED_NODE_SNAPSHOT_TYPE_null.svg -crlf
-LayoutTests/dom/svg/level3/xpath/XPathResult_snapshotLength_ORDERED_NODE_SNAPSHOT_TYPE.svg -crlf
-LayoutTests/dom/svg/level3/xpath/XPathResult_snapshotLength_UNORDERED_NODE_SNAPSHOT_TYPE.svg -crlf
-LayoutTests/dom/svg/level3/xpath/XPathResult_stringValue.svg -crlf
-LayoutTests/editing/execCommand/align-in-span.html -crlf
-LayoutTests/editing/selection/drag-start-event-client-x-y.html -crlf
-LayoutTests/fast/backgrounds/background-position-rounding.html -crlf
-LayoutTests/fast/backgrounds/repeat/resources/background-repeat-shorthand.js -crlf
-LayoutTests/fast/backgrounds/repeat/resources/margin-shorthand.js -crlf
-LayoutTests/fast/block/float/clamped-right-float.html -crlf
-LayoutTests/fast/block/positioning/absolute-with-html-border-quirks.html -crlf
-LayoutTests/fast/block/positioning/absolute-with-html-border-strict.html -crlf
-LayoutTests/fast/canvas/script-tests/canvas-gradient-without-path.js -crlf
-LayoutTests/fast/css/color-quirk.html -crlf
-LayoutTests/fast/css/color-strict.html -crlf
-LayoutTests/fast/css/css1_forward_compatible_parsing.html -crlf
-LayoutTests/fast/css/empty-pseudo-class.html -crlf
-LayoutTests/fast/css/first-child-pseudo-class.html -crlf
-LayoutTests/fast/css/first-of-type-pseudo-class.html -crlf
-LayoutTests/fast/css/last-child-pseudo-class.html -crlf
-LayoutTests/fast/css/last-of-type-pseudo-class.html -crlf
-LayoutTests/fast/css/only-child-pseudo-class.html -crlf
-LayoutTests/fast/css/only-of-type-pseudo-class.html -crlf
-LayoutTests/fast/css/text-input-with-webkit-border-radius.html -crlf
-LayoutTests/fast/dom/Document/open-with-pending-load.html -crlf
-LayoutTests/fast/dom/Element/hostname-host.html -crlf
-LayoutTests/fast/dom/StyleSheet/ownerNode-lifetime-2.html -crlf
-LayoutTests/fast/dom/Window/window-property-clearing-expected.txt -crlf
-LayoutTests/fast/dom/everything-to-string.html -crlf
-LayoutTests/fast/dom/insert-span-into-long-text-bug-28245.html -crlf
-LayoutTests/fast/dom/resources/TestApplet.java -crlf
-LayoutTests/fast/dom/simultaneouslyRegsiteredTimerFireOrder-expected.txt -crlf
-LayoutTests/fast/dom/timer-clear-interval-in-handler-and-generate-error.html -crlf
-LayoutTests/fast/events/keydown-keypress-focus-change.html -crlf
-LayoutTests/fast/events/node-event-anchor-lock.html -crlf
-LayoutTests/fast/events/onload-fires-twice.html -crlf
-LayoutTests/fast/events/set-event-in-another-frame.html -crlf
-LayoutTests/fast/events/set-event-to-null.html -crlf
-LayoutTests/fast/forms/resources/form-and-frame-interaction-retains-values-main.html -crlf
-LayoutTests/fast/forms/resources/form-and-frame-interaction-retains-values-submit.html -crlf
-LayoutTests/fast/forms/select-remove-option.html -crlf
-LayoutTests/fast/forms/select-reset-multiple-selections-4-single-selection.html -crlf
-LayoutTests/fast/forms/textfield-onchange-deletion.html -crlf
-LayoutTests/fast/frames/frame-src-attribute.html -crlf
-LayoutTests/fast/frames/iframe-scroll-page-up-down.html-disabled -crlf
-LayoutTests/fast/frames/javascript-url-as-framesrc-crash.html -crlf
-LayoutTests/fast/frames/resources/iframe-scroll-page-up-down-1.html -crlf
-LayoutTests/fast/frames/resources/iframe-scroll-page-up-down-2.html -crlf
-LayoutTests/fast/frames/viewsource-attribute.html -crlf
-LayoutTests/fast/inline/inline-padding-disables-text-quirk.html -crlf
-LayoutTests/fast/loader/submit-form-while-parsing-1.xhtml -crlf
-LayoutTests/fast/overflow/dynamic-hidden.html -crlf
-LayoutTests/fast/parser/external-entities-in-xslt.xml -crlf
-LayoutTests/fast/parser/external-entities.xml -crlf
-LayoutTests/fast/parser/resources/external-entities.xsl -crlf
-LayoutTests/fast/replaced/replaced-breaking.html -crlf
-LayoutTests/fast/table/dynamic-cellpadding.html -crlf
-LayoutTests/fast/table/fixed-table-with-percent-inside-percent-table.html -crlf
-LayoutTests/fast/table/fixed-table-with-percent-width-inside-auto-table.html -crlf
-LayoutTests/fast/table/fixed-table-with-percent-width-inside-extra-large-div.html -crlf
-LayoutTests/fast/table/fixed-table-with-small-percent-width.html -crlf
-LayoutTests/fast/table/rules-attr-dynchange1.html -crlf
-LayoutTests/fast/table/rules-attr-dynchange2.html -crlf
-LayoutTests/fast/text/international/thai-baht-space.html -crlf
-LayoutTests/fast/text/resources/line-breaks-crlf.txt -crlf
-LayoutTests/fast/text/text-large-negative-letter-spacing-with-opacity.html -crlf
-LayoutTests/fast/text/text-letter-spacing.html -crlf
-LayoutTests/http/tests/appcache/max-size.html -crlf
-LayoutTests/http/tests/misc/location-test-xsl-style-sheet.xml -crlf
-LayoutTests/http/tests/misc/resources/location-test-xsl-style-sheet.xsl -crlf
-LayoutTests/http/tests/misc/single-character-pi-stylesheet.xhtml -crlf
-LayoutTests/http/tests/misc/will-send-request-returns-null-on-redirect.html -crlf
-LayoutTests/http/tests/navigation/no-referrer-reset.html -crlf
-LayoutTests/http/tests/navigation/no-referrer-same-window.html -crlf
-LayoutTests/http/tests/navigation/no-referrer-subframe.html -crlf
-LayoutTests/http/tests/navigation/no-referrer-target-blank.html -crlf
-LayoutTests/http/tests/navigation/resources/no-referrer-same-window-helper.php -crlf
-LayoutTests/http/tests/security/isolatedWorld/events.html -crlf
-LayoutTests/http/tests/security/isolatedWorld/resources/iframe.html -crlf
-LayoutTests/http/tests/security/isolatedWorld/resources/userGestureEvents-second-window.html -crlf
-LayoutTests/http/tests/security/isolatedWorld/userGestureEvents.html -crlf
-LayoutTests/http/tests/security/resources/empty-svg.php -crlf
-LayoutTests/platform/win/fast/events/panScroll-event-fired.html -crlf
-LayoutTests/platform/win/fast/events/panScroll-image-no-scroll.html -crlf
-LayoutTests/platform/win/fast/events/panScroll-imageMap-href-no-scroll.html -crlf
-LayoutTests/platform/win/fast/events/panScroll-imageMap-noHref-scroll.html -crlf
-LayoutTests/platform/win/fast/events/panScroll-nested-divs.html -crlf
-LayoutTests/platform/win/fast/events/panScroll-no-iframe-jump.html -crlf
-LayoutTests/platform/win/fast/events/panScroll-preventDefault.html -crlf
-LayoutTests/svg/custom/marker-opacity.svg -crlf
-LayoutTests/svg/custom/resources/graffiti.svg -crlf
-LayoutTests/svg/custom/struct-use-09-b.svg -crlf
-LayoutTests/svg/custom/svg-fonts-in-html.html -crlf
-LayoutTests/svg/custom/use-events-crash.svg -crlf
-LayoutTests/svg/custom/use-on-symbol-inside-pattern.svg -crlf
-LayoutTests/svg/custom/use-setAttribute-crash.svg -crlf
-LayoutTests/svg/custom/xml-stylesheet.svg -crlf
-LayoutTests/tables/mozilla/bugs/bug119786.html -crlf
-LayoutTests/tables/mozilla/bugs/bug222846.html -crlf
-LayoutTests/tables/mozilla/bugs/bug275625.html -crlf
-LayoutTests/tables/mozilla/images/aboutHeader.gif -crlf
-LayoutTests/tables/mozilla/images/main-horizontal-scroll.gif -crlf
-LayoutTests/tables/mozilla_expected_failures/bugs/bug101759.html -crlf
-LayoutTests/tables/mozilla_expected_failures/bugs/bug14489.html -crlf
-LayoutTests/tables/mozilla_expected_failures/images/aboutHeader.gif -crlf
-LayoutTests/tables/mozilla_expected_failures/images/main-horizontal-scroll.gif -crlf
-LayoutTests/wml/resources/enter-card-with-events.wml -crlf
-LayoutTests/wml/resources/enter-first-card-with-events.wml -crlf
-ManualTests/DOMContextMenuEvent.html -crlf
-ManualTests/cursor-max-size.html -crlf
-ManualTests/drag-with-div-or-image-as-data-image.html -crlf
-ManualTests/empty-script-crash.html -crlf
-ManualTests/remove-form-node-with-radio-buttons-crash.html -crlf
-ManualTests/select-delete-item.html -crlf
-ManualTests/textarea-caret-position-after-auto-spell-correct.html -crlf
-PerformanceTests/PageLoad/svg/files/Harvey_Rayner.svg -crlf
-PerformanceTests/PageLoad/svg/files/cacuts_02.svg -crlf
-PerformanceTests/PageLoad/svg/files/crawfish2_ganson.svg -crlf
-PerformanceTests/PageLoad/svg/files/france.svg -crlf
-PerformanceTests/PageLoad/svg/files/mtsthelens.svg -crlf
-PerformanceTests/PageLoad/svg/files/worldcup.svg -crlf
-PerformanceTests/SunSpider/tests/parse-only/jquery-1.3.2.js -crlf
-Source/WebCore/accessibility/AccessibilityAllInOne.cpp -crlf
-Source/WebCore/bindings/js/JSExceptionBase.cpp -crlf
-Source/WebCore/bindings/js/JSExceptionBase.h -crlf
-Source/WebCore/inspector/Inspector.json -crlf
-Source/WebCore/platform/chromium/SuddenTerminationChromium.cpp -crlf
-Source/WebCore/platform/network/win/NetworkStateNotifierWin.cpp -crlf
-Source/WebCore/platform/wx/wxcode/non-kerned-drawing.h -crlf
-Source/WebCore/rendering/RenderThemeChromiumWin.h -crlf
-Tools/BuildSlaveSupport/win/kill-old-processes -crlf
-Tools/DumpRenderTree/cairo/PixelDumpSupportCairo.cpp -crlf
-Tools/FindSafari/Safari.exe.manifest -crlf
-Tools/MiniBrowser/win/MiniBrowser.rc -crlf
-Tools/TestResultServer/index.yaml -crlf
-Tools/WinLauncher/WinLauncher.h -crlf
-Tools/record-memory-win/main.cpp -crlf
-WebKit/chromium/src/EventListenerWrapper.cpp -crlf
-WebKit/chromium/src/EventListenerWrapper.h -crlf
-WebKit/chromium/src/WebEventListener.cpp -crlf
-WebKit/chromium/src/WebEventListenerPrivate.cpp -crlf
-WebKit/chromium/src/WebEventListenerPrivate.h -crlf
-WebKit/gtk/po/sr.po -crlf
-WebKit/gtk/po/sr@latin.po -crlf
-WebKit/qt/tests/qwebframe/resources/testiframe.html -crlf
-WebKit/qt/tests/qwebframe/resources/testiframe2.html -crlf
-WebKit/win/COMPropertyBag.h -crlf
-WebKit/win/COMVariantSetter.h -crlf
-WebKit/win/Interfaces/IWebEmbeddedView.idl -crlf
-WebKit/win/Interfaces/JavaScriptCoreAPITypes.idl -crlf
-WebKit/win/WebCoreSupport/EmbeddedWidget.cpp -crlf
-WebKit/win/WebCoreSupport/EmbeddedWidget.h -crlf
-WebKit/win/WebCoreSupport/WebInspectorDelegate.h -crlf
-WebKit/win/WebIconFetcher.cpp -crlf
-WebKit/win/WebIconFetcher.h -crlf
-Websites/planet.webkit.org/planet/LICENCE -crlf
-Websites/webkit.org/blog/license.txt -crlf
-Websites/webkit.org/blog/wp-config-sample.php -crlf
-Websites/webkit.org/blog/wp-config.php -crlf
-Websites/webkit.org/blog/wp-includes/images/crystal/license.txt -crlf
-Websites/webkit.org/blog/wp-includes/js/scriptaculous/MIT-LICENSE -crlf
-Websites/webkit.org/blog/wp-includes/js/swfupload/plugins/swfupload.speed.js -crlf
-Websites/webkit.org/blog/wp-includes/js/tinymce/license.txt -crlf
-Websites/webkit.org/perf/slickspeed/frameworks/DomQuery.js -crlf
diff --git a/.gitignore b/.gitignore
index f545cea..fac89dc 100644
--- a/.gitignore
+++ b/.gitignore
@@ -21,111 +21,15 @@ tags
 *~
 *.swp
 
-# Ignore Chromium projects auto-generated from .gyp files:
-Source/JavaScriptCore/JavaScriptCore.gyp/*.Makefile
-Source/JavaScriptCore/JavaScriptCore.gyp/*.mk
-Source/JavaScriptCore/JavaScriptCore.gyp/*.sln
-Source/JavaScriptCore/JavaScriptCore.gyp/*.vcproj*
-Source/JavaScriptCore/JavaScriptCore.gyp/JavaScriptCore.xcodeproj
-Source/ThirdParty/glu/*.Makefile
-Source/ThirdParty/glu/*.mk
-Source/ThirdParty/glu/*.sln
-Source/ThirdParty/glu/*.vcproj
-Source/ThirdParty/glu/glu.xcodeproj
-Source/WTF/WTF.gyp/*.Makefile
-Source/WTF/WTF.gyp/*.mk
-Source/WTF/WTF.gyp/*.sln
-Source/WTF/WTF.gyp/*.vcproj*
-Source/WTF/WTF.gyp/WTF.xcodeproj
-Source/WebCore/WebCore.gyp/*.Makefile
-Source/WebCore/WebCore.gyp/*.mk
-Source/WebCore/WebCore.gyp/*.rules
-Source/WebCore/WebCore.gyp/*.sln
-Source/WebCore/WebCore.gyp/*.tmp
-Source/WebCore/WebCore.gyp/*.vcproj*
-Source/WebCore/WebCore.gyp/WebCore.xcodeproj
-Source/WebKit/chromium/*.Makefile
-Source/WebKit/chromium/*.mk
-Source/WebKit/chromium/*.sln
-Source/WebKit/chromium/*.vcproj*
-Source/WebKit/chromium/All.xcodeproj
-Source/WebKit/chromium/WebKit.xcodeproj
-Source/WebKit/chromium/WebKitUnitTests.xcodeproj
-Source/Platform/Platform.gyp/*.Makefile
-Source/Platform/Platform.gyp/*.mk
-Source/Platform/Platform.gyp/*.sln
-Source/Platform/Platform.gyp/*.vcproj*
-Source/Platform/Platform.gyp/*.xcodeproj*
-Tools/DumpRenderTree/DumpRenderTree.gyp/*.Makefile
-Tools/DumpRenderTree/DumpRenderTree.gyp/*.mk
-Tools/DumpRenderTree/DumpRenderTree.gyp/*.sln
-Tools/DumpRenderTree/DumpRenderTree.gyp/*.vcproj*
-Tools/DumpRenderTree/DumpRenderTree.gyp/*.xcodeproj*
-Tools/TestWebKitAPI/TestWebKitAPI.gyp/*.Makefile
-Tools/TestWebKitAPI/TestWebKitAPI.gyp/*.mk
-Tools/TestWebKitAPI/TestWebKitAPI.gyp/*.sln
-Tools/TestWebKitAPI/TestWebKitAPI.gyp/*.vcproj*
-Tools/TestWebKitAPI/TestWebKitAPI.gyp/*.xcodeproj*
-
-
-# Ignore status files that manage Chromium dependencies.
-Source/WebKit/chromium/.gclient
-Source/WebKit/chromium/.gclient_entries
-
-# Ignore Chromium dependencies
-Source/WebKit/chromium/.gclient
-Source/WebKit/chromium/.gclient_entries
-Source/WebKit/chromium/base/
-Source/WebKit/chromium/chromium_deps/
-Source/WebKit/chromium/crypto/
-Source/WebKit/chromium/depot_tools/
-Source/WebKit/chromium/dbus/
-Source/WebKit/chromium/gfx/
-Source/WebKit/chromium/googleurl/
-Source/WebKit/chromium/gpu/
-Source/WebKit/chromium/ipc/
-Source/WebKit/chromium/media/
-Source/WebKit/chromium/net/
-Source/WebKit/chromium/ppapi/
-Source/WebKit/chromium/printing/
-Source/WebKit/chromium/sdch/
-Source/WebKit/chromium/skia/
-Source/WebKit/chromium/sql/
-Source/WebKit/chromium/testing/
-Source/WebKit/chromium/third_party/
-Source/WebKit/chromium/tools/
-Source/WebKit/chromium/ui/
-Source/WebKit/chromium/v8/
-Source/WebKit/chromium/webkit/
-Source/WebKit/chromium/xcodebuild/
-
 # Ignore files that Chromium port generates
 /Makefile.chromium
 /out
 /gyp-mac-tool
 
-# Ignore compiled java tests:
-LayoutTests/java/*.class
-
 # Though the GTK build builds in a subdirectory, autogen.sh still deposits
 # a few files into the source tree.
 /aclocal.m4
 /autom4te.cache
-/Source/autotools/compile
-/Source/autotools/config.guess
-/Source/autotools/config.sub
-/Source/autotools/depcomp
-/Source/autotools/gtk-doc.m4
-/Source/autotools/install-sh
-/Source/autotools/libtool.m4
-/Source/autotools/ltmain.sh
-/Source/autotools/ltoptions.m4
-/Source/autotools/ltsugar.m4
-/Source/autotools/ltversion.m4
-/Source/autotools/lt~obsolete.m4
-/Source/autotools/missing
-/Source/WebKit/gtk/docs/GNUmakefile.in
-/Source/WebKit/gtk/po/*.pot
 /autotoolsconfig.h.in
 /configure
 /GNUmakefile.in
@@ -133,60 +37,6 @@ LayoutTests/java/*.class
 /INSTALL
 /README
 
-# Ignore files installed by WebKitSupportLibrary/WebKitAuxiliaryLibrary
-/WebKitSupportLibrary.zip
-/WebKitLibraries/win/Software License Agreement for WebKit Support Libraries.rtf
-/WebKitLibraries/win/WebKitAuxiliaryLibrary.headers
-/WebKitLibraries/win/WebKitAuxiliaryLibraryVersion
-/WebKitLibraries/win/WebKitChangesToPthreads.diff
-/WebKitLibraries/win/include/ApplicationServices/
-/WebKitLibraries/win/include/AssertMacros.h
-/WebKitLibraries/win/include/Availability.h
-/WebKitLibraries/win/include/AvailabilityInternal.h
-/WebKitLibraries/win/include/AvailabilityMacros.h
-/WebKitLibraries/win/include/CFNetwork/
-/WebKitLibraries/win/include/ColorSync/
-/WebKitLibraries/win/include/ConditionalMacros.h
-/WebKitLibraries/win/include/CoreFoundation/
-/WebKitLibraries/win/include/CoreGraphics/
-/WebKitLibraries/win/include/CoreServices/
-/WebKitLibraries/win/include/ImageIO/
-/WebKitLibraries/win/include/QuartzCore/
-/WebKitLibraries/win/include/SQLite/
-/WebKitLibraries/win/include/SafariTheme/
-/WebKitLibraries/win/include/TargetConditionals.h
-/WebKitLibraries/win/include/checkint.h
-/WebKitLibraries/win/include/dispatch/
-/WebKitLibraries/win/include/inttypes.h
-/WebKitLibraries/win/include/libxml/
-/WebKitLibraries/win/include/libxslt/
-/WebKitLibraries/win/include/pthreads/
-/WebKitLibraries/win/include/stdbool.h
-/WebKitLibraries/win/include/stdint.h
-/WebKitLibraries/win/include/unicode/
-/WebKitLibraries/win/include/unistd.h
-/WebKitLibraries/win/include/xlocale.h
-/WebKitLibraries/win/include/zlib/
-/WebKitLibraries/win/lib/CFNetwork.lib
-/WebKitLibraries/win/lib/CoreFoundation.lib
-/WebKitLibraries/win/lib/CoreGraphics.lib
-/WebKitLibraries/win/lib/QuartzCore.lib
-/WebKitLibraries/win/lib/SQLite3.lib
-/WebKitLibraries/win/lib/SafariTheme.lib
-/WebKitLibraries/win/lib/icuin.lib
-/WebKitLibraries/win/lib/icuuc.lib
-/WebKitLibraries/win/lib/libdispatch.lib
-/WebKitLibraries/win/lib/libicuin.lib
-/WebKitLibraries/win/lib/libicuuc.lib
-/WebKitLibraries/win/lib/libxml2.lib
-/WebKitLibraries/win/lib/libxslt.lib
-/WebKitLibraries/win/lib/pthreadVC2.lib
-/WebKitLibraries/win/lib/zdll.lib
-
-# Ignore files generated by the Qt build-system:
-Source/qtwebkitversion.h
-Tools/qmake/.build-hint
-
 # Ignore files generated by Qt Creator:
 *.pro.user
 
@@ -198,3 +48,4 @@ Tools/qmake/.build-hint
 # Ignore Eclipse files:
 .project
 .cproject
+WebKitSupportLibrary.zip
diff --git a/LayoutTests/dom/svg/level3/xpath/.gitattributes b/LayoutTests/dom/svg/level3/xpath/.gitattributes
new file mode 100644
index 0000000..b2ecbf4
--- /dev/null
+++ b/LayoutTests/dom/svg/level3/xpath/.gitattributes
@@ -0,0 +1,64 @@
+Attribute_Nodes.svg -crlf
+Attribute_Nodes_xmlns.svg -crlf
+Comment_Nodes.svg -crlf
+Conformance_Expressions.svg -crlf
+Conformance_ID.svg -crlf
+Conformance_hasFeature_3.svg -crlf
+Conformance_hasFeature_empty.svg -crlf
+Conformance_hasFeature_null.svg -crlf
+Conformance_isSupported_3.svg -crlf
+Conformance_isSupported_empty.svg -crlf
+Conformance_isSupported_null.svg -crlf
+Element_Nodes.svg -crlf
+Processing_Instruction_Nodes.svg -crlf
+Text_Nodes.svg -crlf
+XPathEvaluatorCast01.svg -crlf
+XPathEvaluator_createExpression_INVALID_EXPRESSION_ERR.svg -crlf
+XPathEvaluator_createExpression_NAMESPACE_ERR_01.svg -crlf
+XPathEvaluator_createExpression_NAMESPACE_ERR_02.svg -crlf
+XPathEvaluator_createExpression_NS.svg -crlf
+XPathEvaluator_createExpression_no_NS.svg -crlf
+XPathEvaluator_createNSResolver_all.svg -crlf
+XPathEvaluator_createNSResolver_document.svg -crlf
+XPathEvaluator_createNSResolver_documentElement.svg -crlf
+XPathEvaluator_evaluate_INVALID_EXPRESSION_ERR.svg -crlf
+XPathEvaluator_evaluate_NAMESPACE_ERR.svg -crlf
+XPathEvaluator_evaluate_NOT_SUPPORTED_ERR.svg -crlf
+XPathEvaluator_evaluate_TYPE_ERR.svg -crlf
+XPathEvaluator_evaluate_WRONG_DOCUMENT_ERR.svg -crlf
+XPathEvaluator_evaluate_document.svg -crlf
+XPathEvaluator_evaluate_documentElement.svg -crlf
+XPathExpression_evaluate_NOT_SUPPORTED_ERR.svg -crlf
+XPathExpression_evaluate_WRONG_DOCUMENT_ERR.svg -crlf
+XPathExpression_evaluate_document.svg -crlf
+XPathExpression_evaluate_documentElement.svg -crlf
+XPathNSResolver_lookupNamespaceURI_nist_dmstc.svg -crlf
+XPathNSResolver_lookupNamespaceURI_null.svg -crlf
+XPathNSResolver_lookupNamespaceURI_prefix.svg -crlf
+XPathNSResolver_lookupNamespaceURI_xml.svg -crlf
+XPathResult_TYPE_ERR.svg -crlf
+XPathResult_booleanValue_false.svg -crlf
+XPathResult_booleanValue_true.svg -crlf
+XPathResult_invalidIteratorState_ANY_TYPE.svg -crlf
+XPathResult_invalidIteratorState_ANY_UNORDERED_NODE_TYPE.svg -crlf
+XPathResult_invalidIteratorState_BOOLEAN_TYPE.svg -crlf
+XPathResult_invalidIteratorState_FIRST_ORDERED_NODE_TYPE.svg -crlf
+XPathResult_invalidIteratorState_NUMBER_TYPE.svg -crlf
+XPathResult_invalidIteratorState_ORDERED_NODE_ITERATOR_TYPE.svg -crlf
+XPathResult_invalidIteratorState_ORDERED_NODE_SNAPSHOT_TYPE.svg -crlf
+XPathResult_invalidIteratorState_STRING_TYPE.svg -crlf
+XPathResult_invalidIteratorState_UNORDERED_NODE_ITERATOR_TYPE.svg -crlf
+XPathResult_invalidIteratorState_UNORDERED_NODE_SNAPSHOT_TYPE.svg -crlf
+XPathResult_iterateNext_INVALID_STATE_ERR.svg -crlf
+XPathResult_iteratorNext_ORDERED_NODE_ITERATOR_TYPE.svg -crlf
+XPathResult_numberValue.svg -crlf
+XPathResult_resultType.svg -crlf
+XPathResult_singleNodeValue_ANY_UNORDERED_NODE_TYPE.svg -crlf
+XPathResult_singleNodeValue_FIRST_ORDERED_NODE_TYPE.svg -crlf
+XPathResult_snapshotItem_ORDERED_NODE_SNAPSHOT_TYPE_null.svg -crlf
+XPathResult_snapshotItem_ORDERED_NODE_SNAPSHOT_TYPE_order.svg -crlf
+XPathResult_snapshotItem_UNORDERED_NODE_SNAPSHOT_TYPE_count.svg -crlf
+XPathResult_snapshotItem_UNORDERED_NODE_SNAPSHOT_TYPE_null.svg -crlf
+XPathResult_snapshotLength_ORDERED_NODE_SNAPSHOT_TYPE.svg -crlf
+XPathResult_snapshotLength_UNORDERED_NODE_SNAPSHOT_TYPE.svg -crlf
+XPathResult_stringValue.svg -crlf
diff --git a/LayoutTests/editing/execCommand/.gitattributes b/LayoutTests/editing/execCommand/.gitattributes
new file mode 100644
index 0000000..04bf4a9
--- /dev/null
+++ b/LayoutTests/editing/execCommand/.gitattributes
@@ -0,0 +1 @@
+align-in-span.html -crlf
diff --git a/LayoutTests/editing/selection/.gitattributes b/LayoutTests/editing/selection/.gitattributes
new file mode 100644
index 0000000..ca0c670
--- /dev/null
+++ b/LayoutTests/editing/selection/.gitattributes
@@ -0,0 +1 @@
+drag-start-event-client-x-y.html -crlf
diff --git a/LayoutTests/fast/backgrounds/.gitattributes b/LayoutTests/fast/backgrounds/.gitattributes
new file mode 100644
index 0000000..2aa75eb
--- /dev/null
+++ b/LayoutTests/fast/backgrounds/.gitattributes
@@ -0,0 +1 @@
+background-position-rounding.html -crlf
diff --git a/LayoutTests/fast/backgrounds/repeat/resources/.gitattributes b/LayoutTests/fast/backgrounds/repeat/resources/.gitattributes
new file mode 100644
index 0000000..dd027c2
--- /dev/null
+++ b/LayoutTests/fast/backgrounds/repeat/resources/.gitattributes
@@ -0,0 +1,2 @@
+background-repeat-shorthand.js -crlf
+margin-shorthand.js -crlf
diff --git a/LayoutTests/fast/block/float/.gitattributes b/LayoutTests/fast/block/float/.gitattributes
new file mode 100644
index 0000000..f512732
--- /dev/null
+++ b/LayoutTests/fast/block/float/.gitattributes
@@ -0,0 +1 @@
+clamped-right-float.html -crlf
diff --git a/LayoutTests/fast/block/positioning/.gitattributes b/LayoutTests/fast/block/positioning/.gitattributes
new file mode 100644
index 0000000..c0a1894
--- /dev/null
+++ b/LayoutTests/fast/block/positioning/.gitattributes
@@ -0,0 +1,2 @@
+absolute-with-html-border-quirks.html -crlf
+absolute-with-html-border-strict.html -crlf
diff --git a/LayoutTests/fast/canvas/script-tests/.gitattributes b/LayoutTests/fast/canvas/script-tests/.gitattributes
new file mode 100644
index 0000000..05e539b
--- /dev/null
+++ b/LayoutTests/fast/canvas/script-tests/.gitattributes
@@ -0,0 +1 @@
+canvas-gradient-without-path.js -crlf
diff --git a/LayoutTests/fast/css/.gitattributes b/LayoutTests/fast/css/.gitattributes
new file mode 100644
index 0000000..820b6ef
--- /dev/null
+++ b/LayoutTests/fast/css/.gitattributes
@@ -0,0 +1,11 @@
+color-quirk.html -crlf
+color-strict.html -crlf
+css1_forward_compatible_parsing.html -crlf
+empty-pseudo-class.html -crlf
+first-child-pseudo-class.html -crlf
+first-of-type-pseudo-class.html -crlf
+last-child-pseudo-class.html -crlf
+last-of-type-pseudo-class.html -crlf
+only-child-pseudo-class.html -crlf
+only-of-type-pseudo-class.html -crlf
+text-input-with-webkit-border-radius.html -crlf
diff --git a/LayoutTests/fast/dom/.gitattributes b/LayoutTests/fast/dom/.gitattributes
new file mode 100644
index 0000000..a608bdd
--- /dev/null
+++ b/LayoutTests/fast/dom/.gitattributes
@@ -0,0 +1,4 @@
+everything-to-string.html -crlf
+insert-span-into-long-text-bug-28245.html -crlf
+simultaneouslyRegsiteredTimerFireOrder-expected.txt -crlf
+timer-clear-interval-in-handler-and-generate-error.html -crlf
diff --git a/LayoutTests/fast/dom/Document/.gitattributes b/LayoutTests/fast/dom/Document/.gitattributes
new file mode 100644
index 0000000..1243d6b
--- /dev/null
+++ b/LayoutTests/fast/dom/Document/.gitattributes
@@ -0,0 +1 @@
+open-with-pending-load.html -crlf
diff --git a/LayoutTests/fast/dom/Element/.gitattributes b/LayoutTests/fast/dom/Element/.gitattributes
new file mode 100644
index 0000000..7107de1
--- /dev/null
+++ b/LayoutTests/fast/dom/Element/.gitattributes
@@ -0,0 +1 @@
+hostname-host.html -crlf
diff --git a/LayoutTests/fast/dom/StyleSheet/.gitattributes b/LayoutTests/fast/dom/StyleSheet/.gitattributes
new file mode 100644
index 0000000..9b8cfbb
--- /dev/null
+++ b/LayoutTests/fast/dom/StyleSheet/.gitattributes
@@ -0,0 +1 @@
+ownerNode-lifetime-2.html -crlf
diff --git a/LayoutTests/fast/dom/Window/.gitattributes b/LayoutTests/fast/dom/Window/.gitattributes
new file mode 100644
index 0000000..b8c449a
--- /dev/null
+++ b/LayoutTests/fast/dom/Window/.gitattributes
@@ -0,0 +1 @@
+window-property-clearing-expected.txt -crlf
diff --git a/LayoutTests/fast/dom/resources/.gitattributes b/LayoutTests/fast/dom/resources/.gitattributes
new file mode 100644
index 0000000..a6f19cf
--- /dev/null
+++ b/LayoutTests/fast/dom/resources/.gitattributes
@@ -0,0 +1 @@
+TestApplet.java -crlf
diff --git a/LayoutTests/fast/events/.gitattributes b/LayoutTests/fast/events/.gitattributes
new file mode 100644
index 0000000..298edb1
--- /dev/null
+++ b/LayoutTests/fast/events/.gitattributes
@@ -0,0 +1,5 @@
+keydown-keypress-focus-change.html -crlf
+node-event-anchor-lock.html -crlf
+onload-fires-twice.html -crlf
+set-event-in-another-frame.html -crlf
+set-event-to-null.html -crlf
diff --git a/LayoutTests/fast/forms/.gitattributes b/LayoutTests/fast/forms/.gitattributes
new file mode 100644
index 0000000..242fe88
--- /dev/null
+++ b/LayoutTests/fast/forms/.gitattributes
@@ -0,0 +1,3 @@
+select-remove-option.html -crlf
+select-reset-multiple-selections-4-single-selection.html -crlf
+textfield-onchange-deletion.html -crlf
diff --git a/LayoutTests/fast/forms/resources/.gitattributes b/LayoutTests/fast/forms/resources/.gitattributes
new file mode 100644
index 0000000..2e5880c
--- /dev/null
+++ b/LayoutTests/fast/forms/resources/.gitattributes
@@ -0,0 +1,2 @@
+form-and-frame-interaction-retains-values-main.html -crlf
+form-and-frame-interaction-retains-values-submit.html -crlf
diff --git a/LayoutTests/fast/frames/.gitattributes b/LayoutTests/fast/frames/.gitattributes
new file mode 100644
index 0000000..fd8c796
--- /dev/null
+++ b/LayoutTests/fast/frames/.gitattributes
@@ -0,0 +1,4 @@
+frame-src-attribute.html -crlf
+iframe-scroll-page-up-down.html-disabled -crlf
+javascript-url-as-framesrc-crash.html -crlf
+viewsource-attribute.html -crlf
diff --git a/LayoutTests/fast/frames/resources/.gitattributes b/LayoutTests/fast/frames/resources/.gitattributes
new file mode 100644
index 0000000..60c707e
--- /dev/null
+++ b/LayoutTests/fast/frames/resources/.gitattributes
@@ -0,0 +1,2 @@
+iframe-scroll-page-up-down-1.html -crlf
+iframe-scroll-page-up-down-2.html -crlf
diff --git a/LayoutTests/fast/inline/.gitattributes b/LayoutTests/fast/inline/.gitattributes
new file mode 100644
index 0000000..d6777a7
--- /dev/null
+++ b/LayoutTests/fast/inline/.gitattributes
@@ -0,0 +1 @@
+inline-padding-disables-text-quirk.html -crlf
diff --git a/LayoutTests/fast/loader/.gitattributes b/LayoutTests/fast/loader/.gitattributes
new file mode 100644
index 0000000..f5be30c
--- /dev/null
+++ b/LayoutTests/fast/loader/.gitattributes
@@ -0,0 +1 @@
+submit-form-while-parsing-1.xhtml -crlf
diff --git a/LayoutTests/fast/overflow/.gitattributes b/LayoutTests/fast/overflow/.gitattributes
new file mode 100644
index 0000000..ea02989
--- /dev/null
+++ b/LayoutTests/fast/overflow/.gitattributes
@@ -0,0 +1 @@
+dynamic-hidden.html -crlf
diff --git a/LayoutTests/fast/parser/.gitattributes b/LayoutTests/fast/parser/.gitattributes
new file mode 100644
index 0000000..c2f6e89
--- /dev/null
+++ b/LayoutTests/fast/parser/.gitattributes
@@ -0,0 +1,2 @@
+external-entities-in-xslt.xml -crlf
+external-entities.xml -crlf
diff --git a/LayoutTests/fast/parser/resources/.gitattributes b/LayoutTests/fast/parser/resources/.gitattributes
new file mode 100644
index 0000000..1d42fef
--- /dev/null
+++ b/LayoutTests/fast/parser/resources/.gitattributes
@@ -0,0 +1 @@
+external-entities.xsl -crlf
diff --git a/LayoutTests/fast/replaced/.gitattributes b/LayoutTests/fast/replaced/.gitattributes
new file mode 100644
index 0000000..7c26794
--- /dev/null
+++ b/LayoutTests/fast/replaced/.gitattributes
@@ -0,0 +1 @@
+replaced-breaking.html -crlf
diff --git a/LayoutTests/fast/table/.gitattributes b/LayoutTests/fast/table/.gitattributes
new file mode 100644
index 0000000..21dfd1f
--- /dev/null
+++ b/LayoutTests/fast/table/.gitattributes
@@ -0,0 +1,7 @@
+dynamic-cellpadding.html -crlf
+fixed-table-with-percent-inside-percent-table.html -crlf
+fixed-table-with-percent-width-inside-auto-table.html -crlf
+fixed-table-with-percent-width-inside-extra-large-div.html -crlf
+fixed-table-with-small-percent-width.html -crlf
+rules-attr-dynchange1.html -crlf
+rules-attr-dynchange2.html -crlf
diff --git a/LayoutTests/fast/text/.gitattributes b/LayoutTests/fast/text/.gitattributes
new file mode 100644
index 0000000..3b9ef57
--- /dev/null
+++ b/LayoutTests/fast/text/.gitattributes
@@ -0,0 +1,2 @@
+text-large-negative-letter-spacing-with-opacity.html -crlf
+text-letter-spacing.html -crlf
diff --git a/LayoutTests/fast/text/international/.gitattributes b/LayoutTests/fast/text/international/.gitattributes
new file mode 100644
index 0000000..ee4c44c
--- /dev/null
+++ b/LayoutTests/fast/text/international/.gitattributes
@@ -0,0 +1 @@
+thai-baht-space.html -crlf
diff --git a/LayoutTests/fast/text/resources/.gitattributes b/LayoutTests/fast/text/resources/.gitattributes
new file mode 100644
index 0000000..884326c
--- /dev/null
+++ b/LayoutTests/fast/text/resources/.gitattributes
@@ -0,0 +1 @@
+line-breaks-crlf.txt -crlf
diff --git a/LayoutTests/http/tests/appcache/.gitattributes b/LayoutTests/http/tests/appcache/.gitattributes
new file mode 100644
index 0000000..c749988
--- /dev/null
+++ b/LayoutTests/http/tests/appcache/.gitattributes
@@ -0,0 +1 @@
+max-size.html -crlf
diff --git a/LayoutTests/http/tests/misc/.gitattributes b/LayoutTests/http/tests/misc/.gitattributes
new file mode 100644
index 0000000..5634218
--- /dev/null
+++ b/LayoutTests/http/tests/misc/.gitattributes
@@ -0,0 +1,3 @@
+location-test-xsl-style-sheet.xml -crlf
+single-character-pi-stylesheet.xhtml -crlf
+will-send-request-returns-null-on-redirect.html -crlf
diff --git a/LayoutTests/http/tests/misc/resources/.gitattributes b/LayoutTests/http/tests/misc/resources/.gitattributes
new file mode 100644
index 0000000..a5c38d1
--- /dev/null
+++ b/LayoutTests/http/tests/misc/resources/.gitattributes
@@ -0,0 +1 @@
+location-test-xsl-style-sheet.xsl -crlf
diff --git a/LayoutTests/http/tests/navigation/.gitattributes b/LayoutTests/http/tests/navigation/.gitattributes
new file mode 100644
index 0000000..2741d39
--- /dev/null
+++ b/LayoutTests/http/tests/navigation/.gitattributes
@@ -0,0 +1,4 @@
+no-referrer-reset.html -crlf
+no-referrer-same-window.html -crlf
+no-referrer-subframe.html -crlf
+no-referrer-target-blank.html -crlf
diff --git a/LayoutTests/http/tests/navigation/resources/.gitattributes b/LayoutTests/http/tests/navigation/resources/.gitattributes
new file mode 100644
index 0000000..033bbc8
--- /dev/null
+++ b/LayoutTests/http/tests/navigation/resources/.gitattributes
@@ -0,0 +1 @@
+no-referrer-same-window-helper.php -crlf
diff --git a/LayoutTests/http/tests/security/isolatedWorld/.gitattributes b/LayoutTests/http/tests/security/isolatedWorld/.gitattributes
new file mode 100644
index 0000000..af10950
--- /dev/null
+++ b/LayoutTests/http/tests/security/isolatedWorld/.gitattributes
@@ -0,0 +1,2 @@
+events.html -crlf
+userGestureEvents.html -crlf
diff --git a/LayoutTests/http/tests/security/isolatedWorld/resources/.gitattributes b/LayoutTests/http/tests/security/isolatedWorld/resources/.gitattributes
new file mode 100644
index 0000000..06b7c51
--- /dev/null
+++ b/LayoutTests/http/tests/security/isolatedWorld/resources/.gitattributes
@@ -0,0 +1,2 @@
+iframe.html -crlf
+userGestureEvents-second-window.html -crlf
diff --git a/LayoutTests/http/tests/security/resources/.gitattributes b/LayoutTests/http/tests/security/resources/.gitattributes
new file mode 100644
index 0000000..b0a4eac
--- /dev/null
+++ b/LayoutTests/http/tests/security/resources/.gitattributes
@@ -0,0 +1 @@
+empty-svg.php -crlf
diff --git a/LayoutTests/java/.gitignore b/LayoutTests/java/.gitignore
new file mode 100644
index 0000000..6b468b6
--- /dev/null
+++ b/LayoutTests/java/.gitignore
@@ -0,0 +1 @@
+*.class
diff --git a/LayoutTests/platform/win/fast/events/.gitattributes b/LayoutTests/platform/win/fast/events/.gitattributes
new file mode 100644
index 0000000..68eac78
--- /dev/null
+++ b/LayoutTests/platform/win/fast/events/.gitattributes
@@ -0,0 +1,7 @@
+panScroll-event-fired.html -crlf
+panScroll-image-no-scroll.html -crlf
+panScroll-imageMap-href-no-scroll.html -crlf
+panScroll-imageMap-noHref-scroll.html -crlf
+panScroll-nested-divs.html -crlf
+panScroll-no-iframe-jump.html -crlf
+panScroll-preventDefault.html -crlf
diff --git a/LayoutTests/svg/custom/.gitattributes b/LayoutTests/svg/custom/.gitattributes
new file mode 100644
index 0000000..df1b91a
--- /dev/null
+++ b/LayoutTests/svg/custom/.gitattributes
@@ -0,0 +1,7 @@
+marker-opacity.svg -crlf
+struct-use-09-b.svg -crlf
+svg-fonts-in-html.html -crlf
+use-events-crash.svg -crlf
+use-on-symbol-inside-pattern.svg -crlf
+use-setAttribute-crash.svg -crlf
+xml-stylesheet.svg -crlf
diff --git a/LayoutTests/svg/custom/resources/.gitattributes b/LayoutTests/svg/custom/resources/.gitattributes
new file mode 100644
index 0000000..9ab7f69
--- /dev/null
+++ b/LayoutTests/svg/custom/resources/.gitattributes
@@ -0,0 +1 @@
+graffiti.svg -crlf
diff --git a/LayoutTests/tables/mozilla/bugs/.gitattributes b/LayoutTests/tables/mozilla/bugs/.gitattributes
new file mode 100644
index 0000000..d29a664
--- /dev/null
+++ b/LayoutTests/tables/mozilla/bugs/.gitattributes
@@ -0,0 +1,3 @@
+bug119786.html -crlf
+bug222846.html -crlf
+bug275625.html -crlf
diff --git a/LayoutTests/tables/mozilla/images/.gitattributes b/LayoutTests/tables/mozilla/images/.gitattributes
new file mode 100644
index 0000000..c5fc266
--- /dev/null
+++ b/LayoutTests/tables/mozilla/images/.gitattributes
@@ -0,0 +1,2 @@
+aboutHeader.gif -crlf
+main-horizontal-scroll.gif -crlf
diff --git a/LayoutTests/tables/mozilla_expected_failures/bugs/.gitattributes b/LayoutTests/tables/mozilla_expected_failures/bugs/.gitattributes
new file mode 100644
index 0000000..2e2821e
--- /dev/null
+++ b/LayoutTests/tables/mozilla_expected_failures/bugs/.gitattributes
@@ -0,0 +1,2 @@
+bug101759.html -crlf
+bug14489.html -crlf
diff --git a/LayoutTests/tables/mozilla_expected_failures/images/.gitattributes b/LayoutTests/tables/mozilla_expected_failures/images/.gitattributes
new file mode 100644
index 0000000..c5fc266
--- /dev/null
+++ b/LayoutTests/tables/mozilla_expected_failures/images/.gitattributes
@@ -0,0 +1,2 @@
+aboutHeader.gif -crlf
+main-horizontal-scroll.gif -crlf
diff --git a/LayoutTests/wml/resources/.gitattributes b/LayoutTests/wml/resources/.gitattributes
new file mode 100644
index 0000000..74b19cc
--- /dev/null
+++ b/LayoutTests/wml/resources/.gitattributes
@@ -0,0 +1,2 @@
+enter-card-with-events.wml -crlf
+enter-first-card-with-events.wml -crlf
diff --git a/ManualTests/.gitattributes b/ManualTests/.gitattributes
new file mode 100644
index 0000000..379f2f5
--- /dev/null
+++ b/ManualTests/.gitattributes
@@ -0,0 +1,7 @@
+DOMContextMenuEvent.html -crlf
+cursor-max-size.html -crlf
+drag-with-div-or-image-as-data-image.html -crlf
+empty-script-crash.html -crlf
+remove-form-node-with-radio-buttons-crash.html -crlf
+select-delete-item.html -crlf
+textarea-caret-position-after-auto-spell-correct.html -crlf
diff --git a/PerformanceTests/PageLoad/svg/files/.gitattributes b/PerformanceTests/PageLoad/svg/files/.gitattributes
new file mode 100644
index 0000000..d787670
--- /dev/null
+++ b/PerformanceTests/PageLoad/svg/files/.gitattributes
@@ -0,0 +1,6 @@
+Harvey_Rayner.svg -crlf
+cacuts_02.svg -crlf
+crawfish2_ganson.svg -crlf
+france.svg -crlf
+mtsthelens.svg -crlf
+worldcup.svg -crlf
diff --git a/PerformanceTests/SunSpider/tests/parse-only/.gitattributes b/PerformanceTests/SunSpider/tests/parse-only/.gitattributes
new file mode 100644
index 0000000..8985d0a
--- /dev/null
+++ b/PerformanceTests/SunSpider/tests/parse-only/.gitattributes
@@ -0,0 +1 @@
+jquery-1.3.2.js -crlf
diff --git a/Source/.gitignore b/Source/.gitignore
new file mode 100644
index 0000000..a890840
--- /dev/null
+++ b/Source/.gitignore
@@ -0,0 +1 @@
+qtwebkitversion.h
diff --git a/Source/JavaScriptCore/JavaScriptCore.gyp/.gitignore b/Source/JavaScriptCore/JavaScriptCore.gyp/.gitignore
new file mode 100644
index 0000000..9b06f58
--- /dev/null
+++ b/Source/JavaScriptCore/JavaScriptCore.gyp/.gitignore
@@ -0,0 +1,5 @@
+*.Makefile
+*.mk
+*.sln
+*.vcproj*
+JavaScriptCore.xcodeproj
diff --git a/Source/Platform/Platform.gyp/.gitignore b/Source/Platform/Platform.gyp/.gitignore
new file mode 100644
index 0000000..72f70a2
--- /dev/null
+++ b/Source/Platform/Platform.gyp/.gitignore
@@ -0,0 +1,5 @@
+*.Makefile
+*.mk
+*.sln
+*.vcproj*
+*.xcodeproj*
diff --git a/Source/ThirdParty/glu/.gitignore b/Source/ThirdParty/glu/.gitignore
new file mode 100644
index 0000000..ce486c6
--- /dev/null
+++ b/Source/ThirdParty/glu/.gitignore
@@ -0,0 +1,5 @@
+*.Makefile
+*.mk
+*.sln
+*.vcproj
+glu.xcodeproj
diff --git a/Source/WTF/WTF.gyp/.gitignore b/Source/WTF/WTF.gyp/.gitignore
new file mode 100644
index 0000000..37f58cd
--- /dev/null
+++ b/Source/WTF/WTF.gyp/.gitignore
@@ -0,0 +1,5 @@
+*.Makefile
+*.mk
+*.sln
+*.vcproj*
+WTF.xcodeproj
diff --git a/Source/WebCore/WebCore.gyp/.gitignore b/Source/WebCore/WebCore.gyp/.gitignore
new file mode 100644
index 0000000..f2f101c
--- /dev/null
+++ b/Source/WebCore/WebCore.gyp/.gitignore
@@ -0,0 +1,7 @@
+*.Makefile
+*.mk
+*.rules
+*.sln
+*.tmp
+*.vcproj*
+WebCore.xcodeproj
diff --git a/Source/WebCore/accessibility/.gitattributes b/Source/WebCore/accessibility/.gitattributes
new file mode 100644
index 0000000..92bc8aa
--- /dev/null
+++ b/Source/WebCore/accessibility/.gitattributes
@@ -0,0 +1 @@
+AccessibilityAllInOne.cpp -crlf
diff --git a/Source/WebCore/bindings/js/.gitattributes b/Source/WebCore/bindings/js/.gitattributes
new file mode 100644
index 0000000..c0c93ec
--- /dev/null
+++ b/Source/WebCore/bindings/js/.gitattributes
@@ -0,0 +1,2 @@
+JSExceptionBase.cpp -crlf
+JSExceptionBase.h -crlf
diff --git a/Source/WebCore/inspector/.gitattributes b/Source/WebCore/inspector/.gitattributes
new file mode 100644
index 0000000..30859d7
--- /dev/null
+++ b/Source/WebCore/inspector/.gitattributes
@@ -0,0 +1 @@
+Inspector.json -crlf
diff --git a/Source/WebCore/platform/chromium/.gitattributes b/Source/WebCore/platform/chromium/.gitattributes
new file mode 100644
index 0000000..36e6332
--- /dev/null
+++ b/Source/WebCore/platform/chromium/.gitattributes
@@ -0,0 +1 @@
+SuddenTerminationChromium.cpp -crlf
diff --git a/Source/WebCore/platform/network/win/.gitattributes b/Source/WebCore/platform/network/win/.gitattributes
new file mode 100644
index 0000000..6cd8b48
--- /dev/null
+++ b/Source/WebCore/platform/network/win/.gitattributes
@@ -0,0 +1 @@
+NetworkStateNotifierWin.cpp -crlf
diff --git a/Source/WebCore/platform/wx/wxcode/.gitattributes b/Source/WebCore/platform/wx/wxcode/.gitattributes
new file mode 100644
index 0000000..2d4de5a
--- /dev/null
+++ b/Source/WebCore/platform/wx/wxcode/.gitattributes
@@ -0,0 +1 @@
+non-kerned-drawing.h -crlf
diff --git a/Source/WebCore/rendering/.gitattributes b/Source/WebCore/rendering/.gitattributes
new file mode 100644
index 0000000..c5494d3
--- /dev/null
+++ b/Source/WebCore/rendering/.gitattributes
@@ -0,0 +1 @@
+RenderThemeChromiumWin.h -crlf
diff --git a/Source/WebKit/chromium/.gitignore b/Source/WebKit/chromium/.gitignore
new file mode 100644
index 0000000..8f2d4e1
--- /dev/null
+++ b/Source/WebKit/chromium/.gitignore
@@ -0,0 +1,32 @@
+*.Makefile
+*.mk
+*.sln
+*.vcproj*
+All.xcodeproj
+WebKit.xcodeproj
+WebKitUnitTests.xcodeproj
+.gclient
+.gclient_entries
+base
+chromium_deps
+crypto
+depot_tools
+dbus
+gfx
+googleurl
+gpu
+ipc
+media
+net
+ppapi
+printing
+sdch
+skia
+sql
+testing
+third_party
+tools
+ui
+v8
+webkit
+xcodebuild
diff --git a/Source/WebKit/gtk/docs/.gitignore b/Source/WebKit/gtk/docs/.gitignore
new file mode 100644
index 0000000..535c651
--- /dev/null
+++ b/Source/WebKit/gtk/docs/.gitignore
@@ -0,0 +1 @@
+GNUmakefile.in
diff --git a/Source/WebKit/gtk/po/.gitignore b/Source/WebKit/gtk/po/.gitignore
new file mode 100644
index 0000000..e3a8c5d
--- /dev/null
+++ b/Source/WebKit/gtk/po/.gitignore
@@ -0,0 +1 @@
+*.pot
diff --git a/Source/autotools/.gitignore b/Source/autotools/.gitignore
new file mode 100644
index 0000000..f02f1fa
--- /dev/null
+++ b/Source/autotools/.gitignore
@@ -0,0 +1,13 @@
+compile
+config.guess
+config.sub
+depcomp
+gtk-doc.m4
+install-sh
+libtool.m4
+ltmain.sh
+ltoptions.m4
+ltsugar.m4
+ltversion.m4
+lt~obsolete.m4
+missing
diff --git a/Tools/BuildSlaveSupport/win/.gitattributes b/Tools/BuildSlaveSupport/win/.gitattributes
new file mode 100644
index 0000000..d952441
--- /dev/null
+++ b/Tools/BuildSlaveSupport/win/.gitattributes
@@ -0,0 +1 @@
+kill-old-processes -crlf
diff --git a/Tools/DumpRenderTree/DumpRenderTree.gyp/.gitignore b/Tools/DumpRenderTree/DumpRenderTree.gyp/.gitignore
new file mode 100644
index 0000000..72f70a2
--- /dev/null
+++ b/Tools/DumpRenderTree/DumpRenderTree.gyp/.gitignore
@@ -0,0 +1,5 @@
+*.Makefile
+*.mk
+*.sln
+*.vcproj*
+*.xcodeproj*
diff --git a/Tools/DumpRenderTree/cairo/.gitattributes b/Tools/DumpRenderTree/cairo/.gitattributes
new file mode 100644
index 0000000..31b4e3c
--- /dev/null
+++ b/Tools/DumpRenderTree/cairo/.gitattributes
@@ -0,0 +1 @@
+PixelDumpSupportCairo.cpp -crlf
diff --git a/Tools/FindSafari/.gitattributes b/Tools/FindSafari/.gitattributes
new file mode 100644
index 0000000..767439c
--- /dev/null
+++ b/Tools/FindSafari/.gitattributes
@@ -0,0 +1 @@
+Safari.exe.manifest -crlf
diff --git a/Tools/MiniBrowser/win/.gitattributes b/Tools/MiniBrowser/win/.gitattributes
new file mode 100644
index 0000000..3cc5165
--- /dev/null
+++ b/Tools/MiniBrowser/win/.gitattributes
@@ -0,0 +1 @@
+MiniBrowser.rc -crlf
diff --git a/Tools/TestResultServer/.gitattributes b/Tools/TestResultServer/.gitattributes
new file mode 100644
index 0000000..8233a98
--- /dev/null
+++ b/Tools/TestResultServer/.gitattributes
@@ -0,0 +1 @@
+index.yaml -crlf
diff --git a/Tools/TestWebKitAPI/TestWebKitAPI.gyp/.gitignore b/Tools/TestWebKitAPI/TestWebKitAPI.gyp/.gitignore
new file mode 100644
index 0000000..72f70a2
--- /dev/null
+++ b/Tools/TestWebKitAPI/TestWebKitAPI.gyp/.gitignore
@@ -0,0 +1,5 @@
+*.Makefile
+*.mk
+*.sln
+*.vcproj*
+*.xcodeproj*
diff --git a/Tools/WinLauncher/.gitattributes b/Tools/WinLauncher/.gitattributes
new file mode 100644
index 0000000..73a057d
--- /dev/null
+++ b/Tools/WinLauncher/.gitattributes
@@ -0,0 +1 @@
+WinLauncher.h -crlf
diff --git a/Tools/qmake/.gitignore b/Tools/qmake/.gitignore
new file mode 100644
index 0000000..52e11bd
--- /dev/null
+++ b/Tools/qmake/.gitignore
@@ -0,0 +1 @@
+.build-hint
diff --git a/Tools/record-memory-win/.gitattributes b/Tools/record-memory-win/.gitattributes
new file mode 100644
index 0000000..7d2ec04
--- /dev/null
+++ b/Tools/record-memory-win/.gitattributes
@@ -0,0 +1 @@
+main.cpp -crlf
diff --git a/WebKit/chromium/src/.gitattributes b/WebKit/chromium/src/.gitattributes
new file mode 100644
index 0000000..f175d03
--- /dev/null
+++ b/WebKit/chromium/src/.gitattributes
@@ -0,0 +1,5 @@
+EventListenerWrapper.cpp -crlf
+EventListenerWrapper.h -crlf
+WebEventListener.cpp -crlf
+WebEventListenerPrivate.cpp -crlf
+WebEventListenerPrivate.h -crlf
diff --git a/WebKit/gtk/po/.gitattributes b/WebKit/gtk/po/.gitattributes
new file mode 100644
index 0000000..a966a9c
--- /dev/null
+++ b/WebKit/gtk/po/.gitattributes
@@ -0,0 +1,2 @@
+sr.po -crlf
+sr@latin.po -crlf
diff --git a/WebKit/qt/tests/qwebframe/resources/.gitattributes b/WebKit/qt/tests/qwebframe/resources/.gitattributes
new file mode 100644
index 0000000..05fe0f9
--- /dev/null
+++ b/WebKit/qt/tests/qwebframe/resources/.gitattributes
@@ -0,0 +1,2 @@
+testiframe.html -crlf
+testiframe2.html -crlf
diff --git a/WebKit/win/.gitattributes b/WebKit/win/.gitattributes
new file mode 100644
index 0000000..d51f44d
--- /dev/null
+++ b/WebKit/win/.gitattributes
@@ -0,0 +1,4 @@
+COMPropertyBag.h -crlf
+COMVariantSetter.h -crlf
+WebIconFetcher.cpp -crlf
+WebIconFetcher.h -crlf
diff --git a/WebKit/win/Interfaces/.gitattributes b/WebKit/win/Interfaces/.gitattributes
new file mode 100644
index 0000000..0013d7e
--- /dev/null
+++ b/WebKit/win/Interfaces/.gitattributes
@@ -0,0 +1,2 @@
+IWebEmbeddedView.idl -crlf
+JavaScriptCoreAPITypes.idl -crlf
diff --git a/WebKit/win/WebCoreSupport/.gitattributes b/WebKit/win/WebCoreSupport/.gitattributes
new file mode 100644
index 0000000..9fbcc3c
--- /dev/null
+++ b/WebKit/win/WebCoreSupport/.gitattributes
@@ -0,0 +1,3 @@
+EmbeddedWidget.cpp -crlf
+EmbeddedWidget.h -crlf
+WebInspectorDelegate.h -crlf
diff --git a/WebKitLibraries/win/.gitignore b/WebKitLibraries/win/.gitignore
new file mode 100644
index 0000000..fd8b39e
--- /dev/null
+++ b/WebKitLibraries/win/.gitignore
@@ -0,0 +1,4 @@
+Software License Agreement for WebKit Support Libraries.rtf
+WebKitAuxiliaryLibrary.headers
+WebKitAuxiliaryLibraryVersion
+WebKitChangesToPthreads.diff
diff --git a/WebKitLibraries/win/include/.gitignore b/WebKitLibraries/win/include/.gitignore
new file mode 100644
index 0000000..77a6ab8
--- /dev/null
+++ b/WebKitLibraries/win/include/.gitignore
@@ -0,0 +1,28 @@
+ApplicationServices
+AssertMacros.h
+Availability.h
+AvailabilityInternal.h
+AvailabilityMacros.h
+CFNetwork
+ColorSync
+ConditionalMacros.h
+CoreFoundation
+CoreGraphics
+CoreServices
+ImageIO
+QuartzCore
+SQLite
+SafariTheme
+TargetConditionals.h
+checkint.h
+dispatch
+inttypes.h
+libxml
+libxslt
+pthreads
+stdbool.h
+stdint.h
+unicode
+unistd.h
+xlocale.h
+zlib
diff --git a/WebKitLibraries/win/lib/.gitignore b/WebKitLibraries/win/lib/.gitignore
new file mode 100644
index 0000000..ae9b657
--- /dev/null
+++ b/WebKitLibraries/win/lib/.gitignore
@@ -0,0 +1,15 @@
+CFNetwork.lib
+CoreFoundation.lib
+CoreGraphics.lib
+QuartzCore.lib
+SQLite3.lib
+SafariTheme.lib
+icuin.lib
+icuuc.lib
+libdispatch.lib
+libicuin.lib
+libicuuc.lib
+libxml2.lib
+libxslt.lib
+pthreadVC2.lib
+zdll.lib
diff --git a/Websites/planet.webkit.org/planet/.gitattributes b/Websites/planet.webkit.org/planet/.gitattributes
new file mode 100644
index 0000000..55db555
--- /dev/null
+++ b/Websites/planet.webkit.org/planet/.gitattributes
@@ -0,0 +1 @@
+LICENCE -crlf
diff --git a/Websites/webkit.org/blog/.gitattributes b/Websites/webkit.org/blog/.gitattributes
new file mode 100644
index 0000000..35ffd3a
--- /dev/null
+++ b/Websites/webkit.org/blog/.gitattributes
@@ -0,0 +1,3 @@
+license.txt -crlf
+wp-config-sample.php -crlf
+wp-config.php -crlf
diff --git a/Websites/webkit.org/blog/wp-includes/images/crystal/.gitattributes b/Websites/webkit.org/blog/wp-includes/images/crystal/.gitattributes
new file mode 100644
index 0000000..346e00c
--- /dev/null
+++ b/Websites/webkit.org/blog/wp-includes/images/crystal/.gitattributes
@@ -0,0 +1 @@
+license.txt -crlf
diff --git a/Websites/webkit.org/blog/wp-includes/js/scriptaculous/.gitattributes b/Websites/webkit.org/blog/wp-includes/js/scriptaculous/.gitattributes
new file mode 100644
index 0000000..eb4ffe5
--- /dev/null
+++ b/Websites/webkit.org/blog/wp-includes/js/scriptaculous/.gitattributes
@@ -0,0 +1 @@
+MIT-LICENSE -crlf
diff --git a/Websites/webkit.org/blog/wp-includes/js/swfupload/plugins/.gitattributes b/Websites/webkit.org/blog/wp-includes/js/swfupload/plugins/.gitattributes
new file mode 100644
index 0000000..7282a9a
--- /dev/null
+++ b/Websites/webkit.org/blog/wp-includes/js/swfupload/plugins/.gitattributes
@@ -0,0 +1 @@
+swfupload.speed.js -crlf
diff --git a/Websites/webkit.org/blog/wp-includes/js/tinymce/.gitattributes b/Websites/webkit.org/blog/wp-includes/js/tinymce/.gitattributes
new file mode 100644
index 0000000..346e00c
--- /dev/null
+++ b/Websites/webkit.org/blog/wp-includes/js/tinymce/.gitattributes
@@ -0,0 +1 @@
+license.txt -crlf
diff --git a/Websites/webkit.org/perf/slickspeed/frameworks/.gitattributes b/Websites/webkit.org/perf/slickspeed/frameworks/.gitattributes
new file mode 100644
index 0000000..f949e6f
--- /dev/null
+++ b/Websites/webkit.org/perf/slickspeed/frameworks/.gitattributes
@@ -0,0 +1 @@
+DomQuery.js -crlf
